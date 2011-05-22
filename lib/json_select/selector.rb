class JSONSelect
  class Selector
    def iterate(json, &blk)
      json.each {|i|   match(i, &blk) } if Array === json
      json.each {|_,v| match(v, &blk) } if Hash  === json
    end
  end
end
