# .wezterm.lua

```lua
local wezterm = require("wezterm")
local c = wezterm.config_builder()
local act = wezterm.action

function getOS()
	-- ask LuaJIT first
	if jit then
		return jit.os
	end

	-- Unix, Linux variants
	local fh, err = assert(io.popen("uname -o 2>/dev/null", "r"))
	if fh then
		osname = fh:read()
	end

	return osname or "Windows"
end

local is_windows = getOS() == "Windows"
local cmd_key = is_windows and "WIN" or "CMD"

local function setup_core()
	if getOS() == "Windows" then
		c.default_prog = { "C:\\Program Files\\Git\\bin\\bash.exe", "--login", "-i" }
	end
	c.set_environment_variables = {
		PATH = "/opt/homebrew/bin:" .. os.getenv("PATH"),
	}

	c.color_scheme = "Tokyo Night"

	-- c.font = wezterm.font("D2Coding", { weight = "Medium" })
	c.font = wezterm.font_with_fallback({ "JetBrainsMonoHangul Nerd Font Mono" }, { weight = "Medium" })
	c.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
	c.font_size = 13

	-- Slightly transparent and blurred background
	c.front_end = "OpenGL"
	c.cell_width = 0.85
	c.freetype_load_target = "Light"
	c.freetype_render_target = "HorizontalLcd"
	c.freetype_load_flags = "NO_HINTING"
	c.custom_block_glyphs = true -- 블록 글리프 자체 계산 (선명도 개선)  [oai_citation:1‡wezterm.org](https://wezterm.org/config/lua/config/custom_block_glyphs.html?utm_source=chatgpt.com)

	-- 📐 줄 높이 및 DPI 조정
	c.line_height = 1.15

	c.window_background_opacity = 0.99
	c.macos_window_background_blur = 15
	-- Removes the title bar, leaving only the tab bar. Keeps
	-- the ability to resize by dragging the window's edges.
	-- On macOS, 'RESIZE|INTEGRATED_BUTTONS' also looks nice if
	-- you want to keep the window controls visible and integrate
	-- them into the tab bar.
	c.window_decorations = "RESIZE"
	-- Sets the font for the window frame (tab bar)
	c.window_frame = {
		font = wezterm.font({ family = "Berkeley Mono", weight = "Bold" }),
		font_size = 11,
	}
	local function segments_for_right_status(window)
		return {
			window:active_workspace(),
			wezterm.strftime("%a %b %-d %H:%M"),
			"MJ",
		}
	end

	wezterm.on("update-status", function(window, _)
		local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
		local segments = segments_for_right_status(window)

		local color_scheme = window:effective_config().resolved_palette
		-- Note the use of wezterm.color.parse here, this returns
		-- a Color object, which comes with functionality for lightening
		-- or darkening the colour (amongst other things).
		local bg = wezterm.color.parse(color_scheme.background)
		local fg = color_scheme.foreground

		-- Each powerline segment is going to be coloured progressively
		-- darker/lighter depending on whether we're on a dark/light colour
		-- scheme. Let's establish the "from" and "to" bounds of our gradient.
		local gradient_to, gradient_from = bg, bg
		gradient_from = gradient_to:lighten(0.2)

		-- Yes, WezTerm supports creating gradients, because why not?! Although
		-- they'd usually be used for setting high fidelity gradients on your terminal's
		-- background, we'll use them here to give us a sample of the powerline segment
		-- colours we need.
		local gradient = wezterm.color.gradient(
			{
				orientation = "Horizontal",
				colors = { gradient_from, gradient_to },
			},
			#segments -- only gives us as many colours as we have segments.
		)

		-- We'll build up the elements to send to wezterm.format in this table.
		local elements = {}

		for i, seg in ipairs(segments) do
			local is_first = i == 1

			if is_first then
				table.insert(elements, { Background = { Color = "none" } })
			end
			table.insert(elements, { Foreground = { Color = gradient[i] } })
			table.insert(elements, { Text = SOLID_LEFT_ARROW })

			table.insert(elements, { Background = { Color = gradient[i] } })
			table.insert(elements, { Foreground = { Color = fg } })
			table.insert(elements, { Text = " " .. seg .. " " })
		end

		window:set_right_status(wezterm.format(elements))
	end)

	c.leader = { key = "l", mods = "CMD", timeout_milliseconds = 1000 }
	c.native_macos_fullscreen_mode = true
end

local function setup_basic_keys()
	c.keys = {
		{ key = "f", mods = "CTRL|CMD", action = wezterm.action.ToggleFullScreen },
		-- Sends ESC + b and ESC + f sequence, which is used
		-- for telling your shell to jump back/forward.
		{
			-- When the left arrow is pressed
			key = "LeftArrow",
			-- With the "Option" key modifier held down
			mods = "OPT",
			-- Perform this action, in this case - sending ESC + B
			-- to the terminal
			action = act.SendString("\x1bb"),
		},
		{
			key = "RightArrow",
			mods = "OPT",
			action = act.SendString("\x1bf"),
		},

		{
			key = ",",
			mods = "SUPER",
			action = act.SpawnCommandInNewTab({
				cwd = wezterm.home_dir,
				args = { "nvim", wezterm.c_file },
			}),
		},

		{
			key = "a",
			-- When we're in leader mode _and_ CTRL + A is pressed...
			mods = "LEADER|CTRL",
			-- Actually send CTRL + A key to the terminal
			action = act.SendKey({ key = "a", mods = "CTRL" }),
		},

		{
			key = "w",
			mods = "CMD",
			action = wezterm.action_callback(function(window, pane)
				local tab = pane:tab()
				local panes = tab:panes()

				if #panes >= 2 then
					window:perform_action(act.CloseCurrentPane({ confirm = false }), pane)
				else
					window:perform_action(act.CloseCurrentTab({ confirm = false }), pane)
				end
			end),
		},
	}
end
-- Table mapping keypresses to actions

c.colors = { foreground = "white", background = "#111111" }

c.animation_fps = 60
c.default_cursor_style = "BlinkingBar"
c.cursor_blink_rate = 400

local function regsiter_smart_splits_multiplexer()
	local w = require("wezterm")

	-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
	local function is_vim(pane)
		-- this is set by the plugin, and unset on ExitPre in Neovim
		return pane:get_user_vars().IS_NVIM == "true"
	end

	local direction_keys = {
		h = "Left",
		j = "Down",
		k = "Up",
		l = "Right",
	}

	local function split_nav(resize_or_move, key)
		return {
			key = key,
			mods = resize_or_move == "resize" and "META" or "CTRL",
			action = w.action_callback(function(win, pane)
				if is_vim(pane) then
					-- pass the keys through to vim/nvim
					win:perform_action({
						SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
					}, pane)
				else
					if resize_or_move == "resize" then
						win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
					else
						win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
					end
				end
			end),
		}
	end

	table.insert(c.keys, split_nav("move", "h"))
	table.insert(c.keys, split_nav("move", "j"))
	table.insert(c.keys, split_nav("move", "k"))
	table.insert(c.keys, split_nav("move", "l"))
	table.insert(c.keys, split_nav("resize", "h"))
	table.insert(c.keys, split_nav("resize", "j"))
	table.insert(c.keys, split_nav("resize", "k"))
	table.insert(c.keys, split_nav("resize", "l"))
end

local function register_split_multiplexing()
	local w = require("wezterm")

	-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
	local function is_vim(pane)
		-- this is set by the plugin, and unset on ExitPre in Neovim
		return pane:get_user_vars().IS_NVIM == "true"
	end

	local function split_nav(is_horizontal)
		local mods = "CMD" .. (is_horizontal and "|ALT" or "")
		return {
			key = "0",
			mods = mods,
			action = w.action_callback(function(win, pane)
				-- if is_vim(pane) then
				-- 	-- pass the keys through to vim/nvim
				-- 	win:perform_action({
				-- 		SendKey = { key = "0", mods = mods },
				-- 	}, pane)

				-- else
				if is_horizontal then
					win:perform_action(act.SplitHorizontal({ domain = "CurrentPaneDomain" }), pane)
				else
					win:perform_action(act.SplitVertical({ domain = "CurrentPaneDomain" }), pane)
				end
				-- end
			end),
		}
	end

	table.insert(c.keys, split_nav(true))
	table.insert(c.keys, split_nav(false))
end
setup_basic_keys()
setup_core()
regsiter_smart_splits_multiplexer()
register_split_multiplexing()

return c
```
