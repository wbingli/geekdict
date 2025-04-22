[![Gem Version](https://badge.fury.io/rb/geekdict.svg)](http://badge.fury.io/rb/geekdict)

Geek Dict
---------
A command line tool for English-Chinese translation.

Install
-------
You can install via rubygems:

	gem install geekdict

Configure
--------
GeekDict requires API keys for certain providers, set as environment variables:

*   **OpenRouter**: Set `OPENROUTER_API_KEY`.
*   **OpenAI**: Set `OPENAI_API_KEY`.
*   **Youdao**: Configuration for Youdao keys is typically handled within its specific module or a separate config file if needed (refer to Youdao provider specifics if used).

### Configuration File (Optional)

You can customize the default provider and model by creating a configuration file at `~/.geekdict.config`. The file should be in YAML format.

**Example `~/.geekdict.config`:**

```yaml
provider: openrouter # 'openai', 'openrouter', or 'youdao'
model: google/gemini-2.5-flash-preview # Specific model for the chosen provider
```

**Defaults:**

*   If the config file is not present or a setting is missing, the tool defaults to:
    *   `provider: openrouter`
    *   `model: google/gemini-2.5-flash-preview`

**Prioritization:**

Settings are applied in the following order (highest priority first):

1.  Command-line options (`--provider`, `--model`)
2.  Values in `~/.geekdict.config`
3.  Hardcoded defaults


Commands
--------
### Translate a word (`t`)

Translates a given word between English and Chinese.

**Usage:**

```bash
geekdict t [options] <word>
```

**Options:**

*   `-p, --provider PROVIDER`: Specify the translation provider (`openai`, `openrouter`, `youdao`). Overrides config file setting.
*   `-m, --model MODEL`: Specify the LLM model to use (e.g., `gpt-4`, `google/gemini-pro`). Overrides config file setting.
*   `-d, --debug`: Enable debug output.
*   `-o, --open`: (Functionality might vary - check specific provider usage)

**Examples:**

```bash
# Use defaults (provider/model from CLI -> config -> hardcoded defaults)
$ geekdict t hello

# Specify provider (uses default/config model for that provider)
$ geekdict t hello -p openai

# Specify model (uses default/config provider)
$ geekdict t hello -m gpt-4

# Specify both provider and model
$ geekdict t hello --provider openrouter --model anthropic/claude-3-haiku

# Use Youdao provider (model option typically ignored)
$ geekdict t hello -p youdao
```

**Example Output (using an LLM provider):**

```
Translation: 你好 (nǐ hǎo)

Explanation:
"你好" (nǐ hǎo) is the standard Mandarin Chinese greeting equivalent to "hello" in English. It's a polite and common way to greet someone.

Examples:
1. 你好，请问有什么可以帮您的吗？
   Hello, may I help you with anything?
2. 他笑着对我说你好。
   He smiled and said hello to me.
```

Command Help
------------
Use the `help` command to get detailed information about commands and options.

```bash
$ geekdict help
Commands:
  geekdict help [COMMAND]  # Describe available commands or one specific command
  geekdict t <word>        # Translate a word
  geekdict v               # Show version

$ geekdict help t
Usage:
  geekdict t [options] <word>

Options:
  -d, [--debug], [--no-debug]
  -o, [--open], [--no-open]
  -p, [--provider=PROVIDER]              # Provider (overrides config: openai/openrouter/youdao)
  -m, [--model=MODEL]                    # LLM model (overrides config)
                                         # Default: false

Translate a word
```

### Shell Alias (Optional)

For faster access, you can create a shell alias. Add the following line to your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`):

```bash
alias t='geekdict t'
```

After adding the alias and restarting your shell or sourcing the configuration file (e.g., `source ~/.zshrc`), you can simply use `t` instead of `geekdict t`:

```bash
# Instead of: geekdict t hello
t hello
```

Development
----------
```
bin/console
pry>GeekDict::CLI.start(['t','test'])
```

### Test
```
rspec
```

### Build
```
gem build geekdict.gemspec
```

### Publish
```
gem push geekdict-<VERSION>.gem
```

License
-------
MIT license
