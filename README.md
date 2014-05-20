Cliprompt
==============

[![Gem Version](https://badge.fury.io/rb/cliprompt.png)](http://rubygems.org/gems/cliprompt)
[![Build Status](https://travis-ci.org/mose/cliprompt.png?branch=master)](https://travis-ci.org/mose/cliprompt)
[![Coverage Status](https://coveralls.io/repos/mose/cliprompt/badge.png?branch=master)](https://coveralls.io/r/mose/cliprompt?branch=master)
[![Dependency Status](https://gemnasium.com/mose/cliprompt.svg)](https://gemnasium.com/mose/cliprompt)
[![Code Climate](https://codeclimate.com/github/mose/cliprompt.png)](https://codeclimate.com/github/mose/cliprompt)

This library provides a simple DSL for managing user interaction in a CLI application. Still under development, not stable yet.

Features
----------

- manages questions, choices, default values, yes/no values (done)
- makes possible to have env vars set for defaults (todo)

Usage
----------

    # add in your Gemfile
    gem 'cliprompt'

Then in your code

```rb
require 'cliprompt'

class Myclass
  extend Cliprompt

  def initialize
    @url = ask "What is the url of Myclass?"
    @ssl = ask "Is it using SSL?", 'y/N'
    @age = ask "What is the age of the captain?", [22,33,=44,55]
  end
end
```

Check [example.rb](https://github.com/mose/cliprompt/blob/master/example.rb) for various possible combinations, or run `rspec -f d` after all that's also what tests are for.

Contributing
-----------------

1. Fork it ( https://github.com/[my-github-username]/cliprompt/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

License
----------

Copyrite (c) 2014 - mose - Distributed under MIT license
