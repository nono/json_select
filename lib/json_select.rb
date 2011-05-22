require "yajl/json_gem"


class JSONSelect
  VERSION = "0.0.1"

  autoload :Group,          "json_select/group"
  autoload :Selector,       "json_select/selector"
  autoload :SelectorsGroup, "json_select/selectors_group"
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
    groups = selector.split(",").map { |str| build_group(str) }
    SelectorsGroup.new(groups)
  end

  def self.build_group(str)
    selectors = str.split(" ").map { |str| build_simple_selector(str) }
    Group.new(selectors)
  end

  def self.build_simple_selector(str)
    case str
    when "*" then Universal.new
    else          TypeSelector.new(str)
    end
  end
end
