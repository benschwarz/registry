# registry

registry is used to mix into a super class that has many or multiple implementations via subclasses. 

This has been described to me as a [factory pattern](http://en.wikipedia.org/wiki/Factory_method_pattern), [John Barton](http://whoisjohnbarton.com/) describes 'registry' as a "metaprogrammed method factory". 

A good example of this is a parser, you might have a parser for json and another for yml.
Register your sub classes to handle certain labels or descriptions, then let the super class decide weather the message you send it can be handled or not.

## Usage

A simple set of parsers: 

    require 'registry'
    
    class Parser
      extend Registry
    end

    class Json < Parser
      identifier :json, :javascript

      def self.parse
        puts "parsing json..."
      end
    end

    class Yaml < Parser
      def self.parse
        puts "parsing yaml..."
      end
    end
    
Look for your the json parser 

    Parser.for(:json).parse
    
Or the Yaml parser. Notice it also uses its class name as an identifier

    Parser.for(:yaml).parse(items)

There is no parser for XML, this will raise a `Registry::NotRegistered` exception

    Parser.for(:xml).parse(items)

Perhaps you'd like to call methods on the matching parser with a block? You can! 

    Parser.for(:json) do
      parse(feed)
    end

## Installation

    gem install registry --source http://gemcutter.org

## Note on Patches/Pull Requests
 
* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a
  future version unintentionally.
* Commit, do not mess with rakefile, version, or history.
  (if you want to have your own version, that is fine but bump version in a commit by itself I can ignore when I pull)
* Send me a pull request. Bonus points for topic branches.

## Copyright

Copyright (c) 2009 Ben Schwarz. See LICENSE for details.
