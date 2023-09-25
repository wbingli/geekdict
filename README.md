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
	测试 (cè shì)

	Explanation:
	The word "测试" in Chinese means "test" in English. It refers to the process of evaluating or examining something to determine its quality, performance, or knowledge. It can be used in various contexts, such as academic exams, software testing, or product quality testing.
	
	Example:
	1. 我们明天有一场数学测试。
	(Wǒmen míngtiān yǒu yī chǎng shùxué cèshì.)
	We have a math test tomorrow.
	
	2. 这个软件需要经过严格的测试才能发布。
	(Zhège ruǎnjiàn xūyào jīngguò yángé de cèshì cáinéng fābù.)
	This software needs to undergo rigorous testing before it can be released.

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
