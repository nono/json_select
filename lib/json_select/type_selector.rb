class JSONSelect::TypeSelector < JSONSelect::Selector
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def match(json, &blk)
    blk.call json if send("is_#{@type}?", json)
    iterate(json, &blk)
  end

  def is_object?(json)
    Hash === json
  end

  def is_array?(json)
    Array === json
  end

  def is_number?(json)
    Numeric === json
  end

  def is_string?(json)
    String === json
  end

  def is_boolean?(json)
    [true, false].include? json
  end

  def is_null?(json)
    json.nil?
  end
end
