class JSONSelect::Universal < JSONSelect::Selector
  def match(json, &blk)
    blk.call json
    iterate(json, &blk)
  end
end
