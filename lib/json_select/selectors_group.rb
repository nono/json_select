class JSONSelect::SelectorsGroup < JSONSelect::Selector
  attr_accessor :groups

  def initialize(groups)
    @groups = groups
  end

  def match(json)
    @groups.each do |group|
      group.match(json) { |x| yield x }
    end
  end
end
