#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect::Group do
  def results_for_groups(groups)
    groups.map! {|grp| JSONSelect::Group.new(grp) }
    group = JSONSelect::SelectorsGroup.new(groups)
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

  it "matches with one group" do
    groups = [
      [JSONSelect::TypeSelector.new("number")]
    ]
    results = results_for_groups(groups)
    results.must_equal [1, 2]
  end

  it "matches with two groups" do
    groups = [
      [JSONSelect::TypeSelector.new("number")],
      [JSONSelect::TypeSelector.new("null")]
    ]
    results = results_for_groups(groups)
    results.must_equal [1, 2, nil]
  end

  it "matches with three groups" do
    groups = [
      [JSONSelect::TypeSelector.new("number")],
      [JSONSelect::TypeSelector.new("null")],
      [JSONSelect::TypeSelector.new("boolean")]
    ]
    results = results_for_groups(groups)
    results.must_equal [1, 2, nil, false]
  end

end
