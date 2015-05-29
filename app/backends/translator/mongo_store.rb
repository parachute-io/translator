module Translator
  class MongoStore
    def initialize(collection)
      @collection = collection
    end

    def keys
      @collection.find.distinct :_id
    end

    def []=(key, value)
      value = nil if value.blank?

# Assessment.collection.find('result_access' => {'$exist' => false}).update({'$set' => {'result_access' => 'all'}, {:multi => true})


      collection.find(_id: key).update({'$set' => {:value => ActiveSupport::JSON.encode(value)}}, {:upsert => true, :safe => true})
    end

    def [](key)
      if document = collection.find(_id: key).first
        document["value"]
      else
        nil
      end
    end

    def destroy_entry(key)
      @collection.remove({:_id => key})
    end

    def searchable?
      true
    end

    def clear_database
      collection.drop
    end

    private

    def collection; @collection; end
  end
end

