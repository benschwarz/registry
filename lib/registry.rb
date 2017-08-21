require 'thread'
require 'registry/store'

module Registry
  class NotRegistered < StandardError;
  end


  def store
    ::Registry::Store.instance
  end

  # Alternative to subclassing, this method allows passing arbitrary
  # structures as "data", keyed by the :keys array.
  #
  # Usage
  # =====
  #
  #     class CacheManager
  #       extend Registry
  #     end
  #
  #     CacheManager.register(:one, :two:, :three, JSON.load(@content))
  #     CacheManager.register(keys: [:one, :two:, :three], item: JSON.load(@content))
  #
  def register(*args, keys: nil, item: nil, &block)
    item = block.call(self) if block && item.nil?
    if (keys.nil? || item.nil?) && args.size >= 1
      item = args.pop if item.nil?
      keys = args if keys.nil?
    end
    identifier(*keys) { item }
  end

  def inherited(klass)
    super(klass)
    klass.send(:identifier, klass.name)
  end

  def self.included(klass)
    klass.extend(Registry)
  end

  def for(id, &block)
    with_item(id) do |klass|
      block ? klass.class_eval(&block) : klass
    end
  end

  def with_item(id, &block)
    nid = normalize(id)
    if store.has_key?(nid)
      klass = store[nid]
      block ? block.call(klass) : klass
    else
      raise NotRegistered, "Class #{self.name} is not registered for #{id}"
    end
  end

  def identifiers
    store.keys.select { |k| store[k] == self }
  end

  private

  # This is the only method that *writes* to the store
  def identifier(*identifiers, &block)
    identifiers.each do |id|
      store[normalize(id)] = block ? block.call(self) : self
      add_method(id)
    end
  end

  def normalize(id)
    id.to_s.downcase.to_sym
  end

  def add_method(id)
    return unless id.is_a?(Symbol)
    line_no     = __LINE__
    method_defs = %Q!
    def self.#{id}
      store[:#{id}]
    end\n!
    module_eval method_defs, __FILE__, line_no
  end
end
