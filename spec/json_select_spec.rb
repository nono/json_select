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
    selector = JSONSelect.compile("number")
    foo_json = JSONSelect.new('{ "foo": 172 }')
    foo_json.match(selector).must_equal [172]
  end

  describe "Compiling selectors" do
    it "builds a simple selector" do
      simple = JSONSelect.build_simple_selector("*")
      simple.must_be_kind_of JSONSelect::Universal
      simple = JSONSelect.build_simple_selector("number")
      simple.must_be_kind_of JSONSelect::TypeSelector
      simple.type.must_equal "number"
    end

    it "builds a group" do
      group = JSONSelect.build_group("number")
      group.must_be_kind_of JSONSelect::Group
      group.sequence.length.must_equal 1
      simple = group.sequence.first
      simple.must_be_kind_of JSONSelect::TypeSelector
      simple.type.must_equal "number"
    end

    it "compiles a selector" do
      groups = JSONSelect.compile("number")
      groups.must_be_kind_of JSONSelect::SelectorsGroup
      groups.groups.length.must_equal 1
      group = groups.groups.first
      group.must_be_kind_of JSONSelect::Group
      group.sequence.length.must_equal 1
      simple = group.sequence.first
      simple.must_be_kind_of JSONSelect::TypeSelector
      simple.type.must_equal "number"
    end

    it "doesn't compile an already compiled selector" do
      selector = JSONSelect::SelectorsGroup.new([])
      groups = JSONSelect.compile(selector)
      groups.must_equal selector
    end
  end
end
