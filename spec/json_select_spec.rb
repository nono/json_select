#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect do
  it "has a version number" do
    JSONSelect::VERSION.must_match /\d+\.\d+\.\d+/
  end

  describe "simple selectors" do
    json_file   = File.expand_path("../basic.json", __FILE__)
    json_string = File.read json_file
    json_select = JSONSelect.new json_string

    it "matches type selectors" do
      json_select.match("number") {|w| w.must_equal 172 }
    end
  end

  it "is possible to compile a selector manually, to reuse it for example" do
    selector = JSONSelect::Selector.compile("number")
    foo_json = JSONSelect.new('{ "foo": 172 }')
    foo_json.match(selector).must_equal [172]
  end
end
