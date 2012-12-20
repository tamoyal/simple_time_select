# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "simple-time-select"
  s.version = "0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Tony Amoyal"]
  s.email = "tonyamoyal@gmail.com"
  s.date = "2011-04-09"
  s.description = "Alternative to time_select provided by Rails."
  s.summary = "Showcase times in a single drop-down with AM and PM, as well as selectable intervals."
  s.homepage = "http://www.tonyamoyal.com"
  s.require_paths = ["lib"]
  s.files = ["lib/simple_time_select.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('0.3') then
      s.add_development_dependency(%q<rails>, [">= 2.3.0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 2.3.0"])
  end
end
