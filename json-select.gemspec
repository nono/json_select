require "./lib/json_select"

Gem::Specification.new do |s|
  s.name             = "json_select"
  s.version          = JSONSelect::VERSION
  s.date             = Time.now.utc.strftime("%Y-%m-%d")
  s.homepage         = "http://github.com/nono/json_select"
  s.authors          = "Bruno Michel"
  s.email            = "bruno.michel@af83.com"
  s.description      = "A Ruby version of JSONSelect, an experimental selector language for JSON."
  s.summary          = "A Ruby version of JSONSelect, an experimental selector language for JSON."
  s.extra_rdoc_files = %w(README.md)
  s.files            = Dir["MIT-LICENSE", "README.md", "Gemfile", "lib/**/*.rb"]
  s.require_paths    = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.add_dependency "parslet", "~>1.2"
  s.add_dependency "yajl-ruby", "~>0.8"
  s.add_development_dependency "minitest", "~>2.0"
end
