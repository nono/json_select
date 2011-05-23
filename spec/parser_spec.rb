#!/usr/bin/env ruby

require "minitest/autorun"
require "json_select"


describe JSONSelect::Parser do
  before do
    @parser = JSONSelect::Parser.new
  end

  it "parses a pseudo" do
    @parser.pseudo.parse(':root')
    @parser.pseudo.parse(':first-child')
  end

  it "parses an hash" do
    @parser.hash.parse('.foo')
  end

  it "parses the universal selector" do
    @parser.universal.parse('*')
  end

  it "parses a type selector" do
    @parser.type_selector.parse('object')
  end

  it "parses a simple selector sequence" do
    @parser.simple_selector_sequence.parse('.foo.bar')
    @parser.simple_selector_sequence.parse('object.foo:root')
  end

  it "parses a selector" do
    @parser.selector.parse('.foo .bar')
    @parser.selector.parse('object:root > .foo number')
  end

  it "parses a selectors group" do
    @parser.selectors_group.parse('.foo,.bar')
    @parser.selectors_group.parse('.foo, .bar string, .baz>number')
  end

  # FIXME
  # it "parses a selector" do
  #   @parser.parse('.foo,.bar')
  #   @parser.parse('.foo, .bar string, .baz>number')
  # end
end
