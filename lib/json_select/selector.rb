class JSONSelect
  class Selector
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

    def iterate(json, &blk)
      json.each {|i|   match(i, &blk) } if Array === json
      json.each {|_,v| match(v, &blk) } if Hash  === json
    end
  end
end
