module Registry
  @@registered = {}
  
  class NotRegistered < StandardError; end
  
  def inherited(klass)
    klass.send(:identifier, klass.name.downcase.to_sym)
  end
  
  def for(id, &block)
    if @@registered.has_key? id
      @@registered[id].class_eval &block
    else
      raise NotRegistered, "There is no #{self.name} registered for #{id}"
    end
  end
  
  private
  def identifier(*identifiers)
    identifiers.each {|i| @@registered[i] = self }
  end
end