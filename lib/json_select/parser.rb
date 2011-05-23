class JSONSelect::Parser < Parslet::Parser
  root :selectors_group
  rule(:selectors_group) { (selector >> (str(',') >> spaces? >> selector).repeat).as(:groups) }
  rule(:selector) { simple_selector_sequence.as(:sequence) >> (combinator >> simple_selector_sequence.as(:sequence)).repeat }

  rule(:combinator) { spaces? >> str('>').as(:child_combinator) >> spaces? | space.repeat(1) }
  rule(:simple_selector_sequence) { (type_selector | universal) >> hash_pseudo.repeat | hash_pseudo.repeat(1) }
  rule(:hash_pseudo) { hash | pseudo }

  rule(:type_selector) { (str('object') | str('array') | str('number') | str('string') | str('boolean') | str('null')).as(:type_selector) }
  rule(:universal) { str('*').as(:universal) }
  rule(:hash) { str('.') >> name.as(:hash) } # TODO json_string
  rule(:pseudo) { str(':') >> pseudo_class_name.as(:pseudo) } # TODO pseudo_function_name

  rule(:pseudo_class_name) { str('root') | str('first-child') | str('last-child') | str('only-child') }
  rule(:name) { match['_a-zA-Z0-9-'].repeat } # TODO

  rule(:space)   { match('\s') }
  rule(:spaces?) { space.repeat }
end
