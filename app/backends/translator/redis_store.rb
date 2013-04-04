module Translator
  class RedisStore
    def initialize(redis)
      @redis = redis
    end

    def keys
      @redis.keys
    end

    def []=(key, value)
      value = nil if value.blank?
      @redis[key] = ActiveSupport::JSON.encode([value])
    end

    def [](key)
      @redis[key]
    end

    def clear_database
      @redis.keys.clone.each {|key| @redis.del key }
    end
  end
end

