# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a personal Neovim configuration based on LazyVim starter template. It extends LazyVim with custom plugins, keymaps, and settings for a Korean software developer focused on modern web development (React, Next.js, TypeScript), mobile development (React Native, Flutter), and iOS/Android development.

## Key Features

- **LazyVim-based**: Built on top of LazyVim with custom extensions
- **Multi-language support**: JavaScript/TypeScript, React, Swift, Kotlin, Java, Python, etc.
- **Tree-sitter syntax highlighting**: Custom highlight queries for multiple languages
- **Git integration**: Diffview, Gitsigns with custom keymaps
- **Smart editing**: Template string support, JSX prop completion, auto-formatting
- **Custom keymaps**: Optimized for productivity with Korean input method support

## Development Commands

### Build/Generation Commands
```bash
# Generate syntax highlighting queries for all languages
pnpm run gen:highlights

# Format Lua code
stylua --config-path=stylua.toml .
```

### Key Scripts
- `script/generate_highlights.mjs` - Generates tree-sitter highlight queries for multiple languages

## Architecture

### Core Structure
- **init.lua**: Entry point, loads LazyVim configuration
- **lua/config/**: Core configuration files
  - `lazy.lua`: LazyVim setup and plugin management
  - `options.lua`: Neovim options and settings
  - `keymaps.lua`: Custom keymaps and shortcuts
  - `autocmds.lua`: Auto-commands
- **lua/plugins/**: Plugin configurations
- **lua/utils/**: Utility functions and helpers
- **after/queries/**: Custom tree-sitter syntax highlighting queries

### Plugin Management
- Uses lazy.nvim for plugin management
- Plugins are organized in `lua/plugins/` directory
- Each plugin has its own configuration file
- LazyVim plugins are imported and extended with custom settings

### Syntax Highlighting
- Custom tree-sitter queries for enhanced syntax highlighting
- Supports multiple languages: C, C++, JavaScript, TypeScript, JSX/TSX, Python, Swift, Kotlin, Java
- Highlights generated via `generate_highlights.mjs` script

### Key Customizations
- **Korean input support**: IME handling and language switching
- **React/JSX enhancements**: Smart prop completion, template string support
- **Git workflow**: Custom keymaps for staging, discarding, and viewing changes
- **LSP integration**: Language server configurations with custom actions
- **Smart navigation**: Window/split management with resize controls

## Important Files

### Configuration Files
- `init.lua`: Main entry point
- `lazy-lock.json`: Plugin version lockfile
- `stylua.toml`: Lua formatting configuration
- `package.json`: Node.js dependencies for highlight generation

### Custom Utilities
- `lua/utils/utils.lua`: Core utility functions
- `lua/utils/blink-source-provider.lua`: Custom completion provider
- `lua/utils/docs.lua`: Documentation utilities

### Theme
- `theme-mj/`: Custom color theme with Lush.nvim

## Development Workflow

1. **Plugin updates**: Managed through lazy.nvim interface
2. **Syntax highlighting**: Run `pnpm run gen:highlights` after modifying queries
3. **Configuration changes**: Edit files in `lua/config/` and `lua/plugins/`
4. **Testing**: Restart Neovim to test configuration changes

## Key Keymaps

Notable custom keymaps include:
- `jk` - Exit insert mode
- `<leader>z` - Open diff view
- `<leader>gr` - Git restore/discard changes
- `<F6>` - Rename symbol
- `<C-h/j/k/l>` - Smart window navigation
- `<Alt-h/j/k/l>` - Window resizing

## Notes

- Configuration is optimized for macOS development environment
- Supports both English and Korean input methods
- Includes specialized support for React/JSX development
- Custom autopairs rules for template strings and JSX
- Integrates with external tools like Xcode for iOS development
