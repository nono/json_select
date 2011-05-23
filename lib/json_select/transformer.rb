class JSONSelect::Transformer < Parslet::Transform
  rule(:groups   => sequence(:g)) { JSONSelect::SelectorsGroup.new(g) }
  rule(:groups   => simple(:g))   { JSONSelect::SelectorsGroup.new([g]) }
  rule(:sequence => sequence(:s)) { JSONSelect::Group.new(s) }
  rule(:sequence => simple(:s))   { JSONSelect::Group.new([s]) }
  # TODO child_combinator

  rule(:type_selector => simple(:x)) { JSONSelect::TypeSelector.new(x) }
  rule(:universal     => simple(:x)) { JSONSelect::Universal.new }
  rule(:hash          => simple(:x)) { x } # TODO
  rule(:pseudo        => simple(:x)) { x } # TODO
end
