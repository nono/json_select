#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect::TypeSelector do
  def results_for_type_selector(type)
    selector = JSONSelect::TypeSelector.new(type)
    results  = []
    selector.match(@input) { |x| results << x }
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

  it "matches object type" do
    results = results_for_type_selector("object")
    results.must_equal [ @input, @input["baz"], @input["baz"]["qux"] ]
  end

  it "matches array type" do
    results = results_for_type_selector("array")
    results.must_equal [ [1, [2]], [2] ]
  end

  it "matches number type" do
    results = results_for_type_selector("number")
    results.must_equal [ 1, 2 ]
  end

  it "matches string type" do
    results = results_for_type_selector("string")
    results.must_equal [ "42" ]
  end

  it "matches boolean type" do
    results = results_for_type_selector("boolean")
    results.must_equal [ false ]
  end

  it "matches null type" do
    results = results_for_type_selector("null")
    results.must_equal [ nil ]
  end
end
