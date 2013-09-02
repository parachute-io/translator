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
      return if key.blank?
      return if @redis[key].blank?
      decoded_value = ActiveSupport::JSON.decode(@redis[key])
      value = decoded_value.is_a?(Array) ? decoded_value.join : decoded_value
      ActiveSupport::JSON.encode(value)
    end

    def clear_database
      @redis.keys.clone.each {|key| @redis.del key }
    end
  end
end

