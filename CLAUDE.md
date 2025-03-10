# GeekDict Development Guidelines

## Build & Test Commands
- Install dependencies: `bundle install`
- Run all tests: `rake spec` or `bundle exec rspec`
- Run single test file: `rspec spec/path/to/spec_file.rb`
- Run specific test: `rspec spec/path/to/spec_file.rb:LINE_NUMBER`
- Run the CLI tool: `bin/geekdict`
- Run interactive console: `bin/console`

## Code Style Guidelines
- **Structure**: Organize code by functionality in namespaced modules
- **Naming**: 
  - CamelCase for modules/classes
  - snake_case for methods/variables
  - Descriptive method names
- **Imports**: Place explicit requires at top of files
- **Formatting**: Use 2-space indentation
- **Error Handling**: Use conditional checks and provide sensible defaults
- **Methods**: Use `module_function` for utility classes
- **Testing**: Write RSpec tests with clear expectations
- **Documentation**: Document public methods and CLI commands

## Architecture
GeekDict is a CLI dictionary/translation tool that supports different translation services (Youdao, Google, OpenAI) with a consistent interface.