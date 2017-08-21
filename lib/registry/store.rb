require 'singleton'

module Registry

  class Store < Hash
    include Singleton

    class << self
      attr_reader :mutex

      def method_missing(method, *args, &block)
        if self.instance.respond_to?(method)
          run_block = ->(klass) { klass.instance.send(method, *args, &block) }
          if method_modifies_state?(method)
            @mutex ||= Mutex.new
            mutex.synchronize { run_block.call(self) }
          else
            run_block.call(self)
          end
        else
          super
        end
      end

      def method_modifies_state?(method)
        %i([]= store delete clear).include?(method)
      end
    end
  end
end
