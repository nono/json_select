#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect::Universal do
  it "matches all keys" do
    input = {
      "foo" => "42",
      "bar" => [1, [2]],
      "baz" => { "qux" => { "quux" => "courge" } }
    }
    expected = [input, "42", [1, [2]], 1, [2], 2, input["baz"], { "quux" => "courge" }, "courge"]
    results = []
    JSONSelect::Universal.new.match(input) { |x| results << x }
    results.must_equal expected
  end
end
