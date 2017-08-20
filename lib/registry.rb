require 'registry/store'

module Registry
  class NotRegistered < StandardError;
  end

  def store
    ::Registry::Store.instance
  end

  def inherited(klass)
    super(klass)
    klass.send(:identifier, klass.name)
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
    store.keys.select { |k| store[k] == self}
  end

  private

  def identifier(*identifiers)
    identifiers.each do |id|
      store[normalize(id)] = self
    end
  end

  def normalize(id)
    id.to_s.downcase.to_sym
  end
end
