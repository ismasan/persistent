# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{persistent}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ismael Celis"]
  s.date = %q{2009-08-05}
  s.description = %q{Tiny plug & play persistence layer for your Ruby objects}
  s.email = %q{ismaelct@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.markdown"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.markdown",
     "Rakefile",
     "VERSION",
     "lib/persistent.rb",
     "lib/persistent/store.rb",
     "spec/persistent_spec.rb",
     "spec/spec_helper.rb",
     "spec/store_spec.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/ismasan/persistent}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{TODO: one-line summary of your gem}
  s.test_files = [
    "spec/persistent_spec.rb",
     "spec/spec_helper.rb",
     "spec/store_spec.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
