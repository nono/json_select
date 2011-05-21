#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect::Selector do
  it "builds a simple selector" do
    simple = JSONSelect::Selector.build_simple_selector("*")
    simple.must_be_kind_of JSONSelect::Universal
    simple = JSONSelect::Selector.build_simple_selector("number")
    simple.must_be_kind_of JSONSelect::TypeSelector
    simple.type.must_equal "number"
  end

  it "builds a group" do
    group = JSONSelect::Selector.build_group("number")
    group.must_be_kind_of JSONSelect::Group
    group.sequence.length.must_equal 1
    simple = group.sequence.first
    simple.must_be_kind_of JSONSelect::TypeSelector
    simple.type.must_equal "number"
  end

  it "compiles a selector" do
    groups = JSONSelect::Selector.compile("number")
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
    groups = JSONSelect::Selector.compile(selector)
    groups.must_equal selector
  end
end
