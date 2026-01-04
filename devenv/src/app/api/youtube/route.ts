import { NextResponse } from "next/server";

const extractVideoId = (url: string) => {
	const patterns = [
		/(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/|youtube\.com\/v\/)([a-zA-Z0-9_-]{11})/,
		/^([a-zA-Z0-9_-]{11})$/,
	];

	for (const pattern of patterns) {
		const match = url.match(pattern);
		if (match) {
			return match[1];
		}
	}
	return null;
};

const fetchVideoMetadata = async (videoId: string) => {
	const videoUrl = `https://www.youtube.com/watch?v=${videoId}`;
	const oembedUrl = `https://www.youtube.com/oembed?url=${encodeURIComponent(videoUrl)}&format=json`;

	const response = await fetch(oembedUrl);
	if (!response.ok) {
		throw new Error("Failed to fetch video metadata");
	}
	const data = await response.json();

	return {
		title: data.title,
		author: data.author_name,
		authorUrl: data.author_url,
		thumbnailUrl: data.thumbnail_url,
		thumbnailWidth: data.thumbnail_width,
		thumbnailHeight: data.thumbnail_height,
	};
};

const fetchTranscript = async (videoId: string) => {
	const { fetchTranscript } = await import("youtube-transcript-plus");
	return fetchTranscript(videoId, { lang: "en" });
};

type TranscriptSegment = {
	text: string;
};

const formatTranscript = (transcriptData: TranscriptSegment[]) => {
	const rawText = transcriptData
		.map((segment) => segment.text)
		.join(" ")
		.replace(/\s+/g, " ")
		.trim();

	const sentences = rawText
		.split(/(?<=[.!?])\s+/)
		.map((s) => s.trim())
		.filter(Boolean);

	return { sentences, formatted: sentences.join("\n\n") };
};

const generateSlug = (title: string) => {
	return title
		.toLowerCase()
		.replace(/[^a-z0-9\s-]/g, "")
		.replace(/\s+/g, "-")
		.replace(/-+/g, "-")
		.substring(0, 50)
		.replace(/-$/, "");
};

export async function POST(request: Request) {
	try {
		const { url } = await request.json();

		if (!url) {
			return NextResponse.json({ error: "URL is required" }, { status: 400 });
		}

		const videoId = extractVideoId(url.trim());
		if (!videoId) {
			return NextResponse.json(
				{ error: "Invalid YouTube URL or Video ID" },
				{ status: 400 },
			);
		}

		const metadata = await fetchVideoMetadata(videoId);

		// biome-ignore lint/suspicious/noImplicitAnyLet: <explanation>
		let transcript;
		try {
			transcript = await fetchTranscript(videoId);
		} catch {
			return NextResponse.json(
				{
					error:
						"Failed to fetch transcript. Video may not have English captions.",
				},
				{ status: 400 },
			);
		}

		const { sentences, formatted } = formatTranscript(transcript);
		const slug = generateSlug(metadata.title);
		const date = new Date().toISOString().replace("Z", "+0900");
		const videoUrl = `https://www.youtube.com/watch?v=${videoId}`;

		const title = metadata.title.replace(/"/g, '\\"');
		const content = `---
title: "${title}"
tag: ["Practice", "Listening"]
category: English
date: ${date}
teaser: ${metadata.thumbnailUrl}
description: ${sentences[0] || ""}
---

## Video Info

- **Channel**: [${metadata.author}](${metadata.authorUrl})
- **Video**: [${metadata.title}](${videoUrl})

![Thumbnail](${metadata.thumbnailUrl})

## Vocabulary

## Hard Sentences

## What did I miss?

## Full Transcript

${formatted}
`;

		return NextResponse.json({
			success: true,
			videoId,
			metadata,
			slug,
			content,
			filename: `${slug}.md`,
		});
	} catch (error) {
		const message = error instanceof Error ? error.message : "Unknown error";
		return NextResponse.json({ error: message }, { status: 500 });
	}
}
