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
    Selector.compile(selector).match(@json) do |m|
      yield m if block_given?
      results << m
    end
    results
  end
end
