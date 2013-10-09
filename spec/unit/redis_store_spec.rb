# encoding: UTF-8
require 'spec_helper'

require "redis"
require "yaml"

describe Translator::RedisStore do
  before :each do
    @store = Translator::RedisStore.new(Redis.new)
    @store.clear_database
  end

  it "should be possible to set translation value" do
    @store["pl.hello.world"] = "Witaj, świecie!"
    @store["pl.hello.world"].should eql("\"Witaj, \\u015bwiecie!\"")
  end

  it "should list all keys" do
    @store["pl.hello.world"] = "Witaj, świecie!"
    @store["en.hello.world"] = "Hello, World!"
    @store.keys.should include("pl.hello.world")
    @store.keys.should include("en.hello.world")
  end

  it "should accept single qoutes" do
    @store["en.single.quote"] = "'test'"
    @store["en.single.quote"].should include("'test'")
  end

  it "should accept double qoutes" do
    @store["en.double.quote"] = "\"test\""
    @store["en.double.quote"].should include("\"\\\"test\\\"\"")
  end

  it "should accept single qoutes from YAML" do
    yaml = YAML.load_file(File.expand_path('../data.yaml', __FILE__))
    @store["single"] = yaml['single']
    @store["single"].should include("test")
  end

  it "should accept double qoutes from YAML" do
    yaml = YAML.load_file(File.expand_path('../data.yaml', __FILE__))
    @store["double"] = yaml['double']
    @store["double"].should include("test")
  end

end