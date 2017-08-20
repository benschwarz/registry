require 'registry'
require 'yaml'
require 'json'

module Support
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
end
