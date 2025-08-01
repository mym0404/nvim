# Code Style and Conventions

## General Conventions
- **Language**: English comments preferred
- **Variable naming**: Clear and descriptive variable names
- **Function style**: For JavaScript-based coding, prefer `const a = () => {}` over `function a()`
- **Context awareness**: Always consider the overall project context and apply appropriate code style

## Lua Configuration Style
- Uses stylua for code formatting with configuration in `stylua.toml`
- Plugin configurations are modular, each in separate files
- LazyVim conventions followed for plugin setup and configuration

## File Organization
- **Modular approach**: Each plugin has its own configuration file
- **Clear separation**: Core config vs plugin config vs utilities
- **Consistent naming**: Files use lowercase with hyphens or underscores

## Korean Development Considerations
- IME handling and language switching support
- Korean input method compatibility in keymaps
- Documentation and comments can be in Korean when appropriate

## Tree-sitter Queries
- Custom syntax highlighting queries for multiple languages
- Generated via automated script for consistency
- Supports C, C++, JavaScript, TypeScript, JSX/TSX, Python, Swift, Kotlin, Java