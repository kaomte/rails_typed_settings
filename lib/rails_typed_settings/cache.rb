module RailsTypedSettings
  class Cache
    attr_accessor :max_size, :store, :last_added, :misses
    attr_accessor :get_value

    def initialize(max_size, &block)
      @max_size = max_size
      @store = {}
      @get_value = block
      @misses = 0
    end
    
    def value(key)
      v = store[key]
      unless v
        @misses = @misses + 1
        v = get_value.call(key)
        add(key, v) if v
      end
      
      v
    end

    def add(key, value)
      store[key] = value

      if store.count > max_size
        remove_last
      end

      self.last_added = key
      value
    end

    def remove(key)
      store.delete(key)
    end
    
    def clear
      self.misses = 0
      self.store = {}
    end

    private

    def remove_last
      store.delete(store.keys.first)
    end
  end
end
