[![Gem Version](https://badge.fury.io/rb/geekdict.svg)](http://badge.fury.io/rb/geekdict)

Geek Dict
---------
A command line tool for translation.

Install
-------
You can install via rubygems:

	gem install geekdict


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

TODOs
-----
It's under active development until it satisfy my needs. Below are something in my mind:
* geekdict list  : List all words you have searched
* geekdict remove : Remove word you know from your new words list
* Use google translate engine as alternative, as well as supporting other target language. Low priority, only focus on Chinese.

License
-------
MIT license
