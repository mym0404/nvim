# Suggested Commands

## Development Commands

### Syntax Highlighting Generation
```bash
# Generate tree-sitter highlight queries for all languages
pnpm run gen:highlights
```

### Code Formatting
```bash
# Format Lua code using stylua
stylua --config-path=stylua.toml .
```

### Testing Configuration
- Restart Neovim to test configuration changes
- No automated test suite available

### System Commands (macOS/Darwin)
```bash
# Standard Unix commands available
ls          # List directory contents
cd          # Change directory
grep        # Search text patterns
find        # Find files and directories
git         # Version control
```

### Plugin Management
- Use lazy.nvim interface within Neovim for plugin updates
- Configuration files located in `lua/plugins/`

### Project Structure Navigation
- Entry point: `init.lua`
- Core config: `lua/config/`
- Plugin configs: `lua/plugins/`
- Utilities: `lua/utils/`
- Custom queries: `after/queries/`
- Theme: `theme-mj/`