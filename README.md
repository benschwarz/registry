[![Build Status](https://travis-ci.org/kigster/registry.svg?branch=master)](https://travis-ci.org/kigster/registry)
[![Code Climate](https://codeclimate.com/github/kigster/registry/badges/gpa.svg)](https://codeclimate.com/github/kigster/registry)
[![Test Coverage](https://codeclimate.com/github/kigster/registry/badges/coverage.svg)](https://codeclimate.com/github/kigster/registry/coverage)
[![Issue Count](https://codeclimate.com/github/kigster/registry/badges/issue_count.svg)](https://codeclimate.com/github/kigster/registry)

# *Registry* — Simple Factory Pattern Ruby Library

**registry** is used to mix into a super class that has many or multiple implementations via subclasses. 

This has been described as a [factory pattern](http://en.wikipedia.org/wiki/Factory_method_pattern), [John Barton](http://whoisjohnbarton.com/) describes 'registry' as a "meta-programming method factory". 

A good example of this is a parser, you might have a parser for json and another for yml. Register your sub classes to handle certain labels or descriptions, then let the super class decide weather the message you send it can be handled or not.

## Usage

A simple set of parsers: 

```ruby
require 'registry'

class Parser
  extend Registry
end

class Json < Parser
  identifier :json, :javascript
  
  def self.parse(source)
    JSON.load(source)
  end
end

class Yaml < Parser
  identifier :yaml, :yml
  
  def self.parse(source)
    YAML.load(source)
  end
end
```
    
Look for your the json parser 

```ruby
Parser.for(:json).parse(content)
```
    
Or the Yaml parser. Notice it also uses its class name as an identifier

```ruby
Parser.for(:yaml).parse(content)
```

There is no parser for XML, this will raise a `Registry::NotRegistered` exception

```ruby
Parser.for(:xml).parse(content)
```

Perhaps you'd like to call methods on the matching parser with a block? You can! 

```ruby
@content = '{"name":"Bobby"}'
Parser.for(:json) do
  parse(@content)
end
# => { 'name' => 'Bobby' }
```

## Installation

    gem install registry 

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, do not mess with rakefile, version, or history. If you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull.
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 Ben Schwarz. See LICENSE for details.

## Contributors

 * [Konstantin Gredeskoul](https://github.com/kigster)
 
 

