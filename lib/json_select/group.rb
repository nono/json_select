class JSONSelect::Group < JSONSelect::Selector
  attr_accessor :sequence

  def initialize(simple_selector_sequence)
    @sequence = simple_selector_sequence
  end

  def match(json, &blk)
    return if @sequence.empty?
    selector = @sequence.shift
    selector.match(json) do |part|
      if @sequence.empty?
        blk.call part
      else
        iterate(part, &blk)
      end
    end
    @sequence.unshift selector
  end
end
