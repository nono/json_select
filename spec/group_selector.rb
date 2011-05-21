#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect::Group do
  def results_for_sequence(selectors)
    group = JSONSelect::Group.new(selectors)
    results = []
    group.match(@input) { |x| results << x }
    results
  end

  before do
    @input = {
      "foo" => "42",
      "bar" => [1, [2]],
      "baz" => { "qux" => { "quux" => false } },
      "non" => nil
    }
  end

  it "matches a sequence of one selector" do
    selectors = [ JSONSelect::TypeSelector.new("number") ]
    results = results_for_sequence(selectors)
    results.must_equal [1, 2]
  end

  it "matches a sequence of two selectors" do
    selectors = [
      JSONSelect::TypeSelector.new("object"),
      JSONSelect::TypeSelector.new("number")
    ]
    results = results_for_sequence(selectors)
    results.must_equal [1, 2]
  end

  it "matches a sequence of three selectors" do
    selectors = [
      JSONSelect::TypeSelector.new("object"),
      JSONSelect::TypeSelector.new("array"),
      JSONSelect::TypeSelector.new("array")
    ]
    results = results_for_sequence(selectors)
    results.must_equal [ [2] ]
  end
end
