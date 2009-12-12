module Registry
  @@registered = {}
  
  class NotRegistered < StandardError; end
  
  def inherited(klass)
    klass.send(:identifier, klass.name)
  end
  
  def for(id, &block)
    if @@registered.has_key? normalize(id)
      klass = @@registered[normalize(id)]
      (block_given?) ? klass.class_eval(&block) : klass
    else
      raise NotRegistered, "There is no #{self.name} registered for #{id}"
    end
  end
  
  private
  def identifier(*identifiers)
    identifiers.each{|id| @@registered[normalize(id)] = self }
  end
  
  def normalize(id)
    id.to_s.downcase
  end
end