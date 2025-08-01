# Task Completion Checklist

## When Making Configuration Changes

### Mandatory Steps
1. **Syntax Check**: Ensure Lua syntax is valid
2. **Restart Neovim**: Required to test configuration changes
3. **Format Code**: Run `stylua --config-path=stylua.toml .` for Lua files

### For Syntax Highlighting Changes
1. **Regenerate Highlights**: Run `pnpm run gen:highlights` after modifying queries
2. **Test in Neovim**: Verify highlighting works correctly for target languages

### For Plugin Changes
1. **Check Plugin Dependencies**: Ensure all required dependencies are available
2. **Test Plugin Functionality**: Verify new plugins or configurations work as expected
3. **Update Documentation**: Update relevant configuration comments

### Git Workflow (if applicable)
1. **Stage Changes**: Use custom keymaps like `<leader>gr` for git operations
2. **Test Before Commit**: Always test configuration changes before committing
3. **Use Conventional Commits**: Follow conventional commit style (feat:, fix:, etc.)

## Quality Assurance
- No automated testing - manual verification required
- Configuration should not break existing functionality
- Korean input method compatibility should be maintained
- Performance impact should be minimal