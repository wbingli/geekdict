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
This translate uses OpenAI's GPT-3.5. Ensure you have `OPENAI_API_KEY` configured as environment variable.


Commands
--------
### Translate a word

	$geekdict t test
	n. 试验；检验
	vt. 试验；测试
	vi. 试验；测试
	n. (Test)人名；(英)特斯特

Command Help
------------
Use *help* command to get detail information.

	$geekdict
	Commands:
	  geekdict help [COMMAND]  # Describe available commands or one specific command
	  geekdict t               # Translate a word

	$geekdict help t
	Usage:
	  geekdict t

	Options:
  -d, [--debug], [--no-debug]
  -o, [--open], [--no-open]

	Translate a word


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
