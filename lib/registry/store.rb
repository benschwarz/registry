require 'singleton'

module Registry

  class Store < Hash
    include Singleton

    class << self
      def method_missing(method, *args, &block)
        if self.instance.respond_to?(method)
          self.instance.send(method, *args, &block)
        else
          super
        end
      end
    end
  end
end
