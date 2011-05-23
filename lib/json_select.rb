require "yajl/json_gem"
require "parslet"


class JSONSelect
  VERSION = "0.0.1"

  autoload :Group,          "json_select/group"
  autoload :Parser,         "json_select/parser"
  autoload :Selector,       "json_select/selector"
  autoload :SelectorsGroup, "json_select/selectors_group"
  autoload :Transformer,    "json_select/transformer"
  autoload :TypeSelector,   "json_select/type_selector"
  autoload :Universal,      "json_select/universal"

  def initialize(str)
    @json = JSON.parse(str)
  end

  def match(selector)
    results = []
    self.class.compile(selector).match(@json) do |m|
      yield m if block_given?
      results << m
    end
    results
  end

  def self.compile(selector)
    return selector if Selector === selector
    parser = JSONSelect::Parser.new
    parser = parser.selectors_group # FIXME
    trans  = JSONSelect::Transformer.new
    trans.apply parser.parse(selector)
  end
end
