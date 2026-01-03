"use client";

import { useState } from "react";

type GeneratorResult = {
	success: boolean;
	videoId: string;
	metadata: {
		title: string;
		author: string;
		authorUrl: string;
		thumbnailUrl: string;
	};
	slug: string;
	content: string;
	filename: string;
};

export const YouTubeGenerator = () => {
	const [url, setUrl] = useState("");
	const [loading, setLoading] = useState(false);
	const [error, setError] = useState<string | null>(null);
	const [result, setResult] = useState<GeneratorResult | null>(null);
	const [copied, setCopied] = useState(false);

	const handleSubmit = async (e: React.FormEvent) => {
		e.preventDefault();
		setLoading(true);
		setError(null);
		setResult(null);

		try {
			const response = await fetch("/api/youtube", {
				method: "POST",
				headers: { "Content-Type": "application/json" },
				body: JSON.stringify({ url }),
			});

			const data = await response.json();

			if (!response.ok) {
				throw new Error(data.error || "Failed to generate post");
			}

			setResult(data);
		} catch (err) {
			setError(err instanceof Error ? err.message : "Unknown error");
		} finally {
			setLoading(false);
		}
	};

	const handleCopy = async () => {
		if (!result) return;
		await navigator.clipboard.writeText(result.content);
		setCopied(true);
		setTimeout(() => setCopied(false), 2000);
	};

	return (
		<div className="mt-6">
			<form onSubmit={handleSubmit} className="flex gap-2">
				<input
					type="text"
					value={url}
					onChange={(e) => setUrl(e.target.value)}
					placeholder="YouTube URL or Video ID"
					className="flex-1 px-4 py-2 border border-gray-300 dark:border-gray-600 rounded-lg bg-white dark:bg-gray-800 text-gray-900 dark:text-gray-100"
					disabled={loading}
				/>
				<button
					type="submit"
					disabled={loading || !url.trim()}
					className="px-6 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
				>
					{loading ? "Generating..." : "Generate"}
				</button>
			</form>

			{error && (
				<div className="mt-4 p-4 bg-red-100 dark:bg-red-900/30 border border-red-400 text-red-700 dark:text-red-400 rounded-lg">
					{error}
				</div>
			)}

			{result && (
				<div className="mt-6">
					<div className="flex items-center justify-between mb-4">
						<div className="flex items-center gap-4">
							<img
								src={result.metadata.thumbnailUrl}
								alt={result.metadata.title}
								className="w-24 h-auto rounded"
							/>
							<div>
								<h3 className="font-semibold text-lg">
									{result.metadata.title}
								</h3>
								<p className="text-gray-600 dark:text-gray-400">
									by{" "}
									<a
										href={result.metadata.authorUrl}
										target="_blank"
										rel="noopener noreferrer"
										className="text-blue-600 hover:underline"
									>
										{result.metadata.author}
									</a>
								</p>
								<p className="text-sm text-gray-500">
									Filename: {result.filename}
								</p>
							</div>
						</div>
						<button
							type={"button"}
							onClick={handleCopy}
							className="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700"
						>
							{copied ? "Copied!" : "Copy Content"}
						</button>
					</div>

					<div className="relative">
						<pre className="p-4 bg-gray-100 dark:bg-gray-800 rounded-lg overflow-x-auto text-sm max-h-96 overflow-y-auto">
							<code>{result.content}</code>
						</pre>
					</div>
				</div>
			)}
		</div>
	);
};
