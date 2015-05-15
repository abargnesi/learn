# -*- encoding: utf-8 -*-
# stub: vim-flavor 2.2.1 ruby lib

Gem::Specification.new do |s|
  s.name = "vim-flavor"
  s.version = "2.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Kana Natsuno"]
  s.date = "2015-04-23"
  s.description = "A tool to manage your favorite Vim plugins"
  s.email = ["dev@whileimautomaton.net"]
  s.executables = ["vim-flavor"]
  s.files = ["bin/vim-flavor"]
  s.homepage = "https://github.com/kana/vim-flavor"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.5"
  s.summary = "A tool to manage your favorite Vim plugins"

  s.installed_by_version = "2.4.5" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<parslet>, ["~> 1.7"])
      s.add_runtime_dependency(%q<thor>, ["~> 0.19"])
      s.add_development_dependency(%q<aruba>, ["~> 0.6"])
      s.add_development_dependency(%q<cucumber>, ["~> 1.3"])
      s.add_development_dependency(%q<pry>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.99"])
    else
      s.add_dependency(%q<parslet>, ["~> 1.7"])
      s.add_dependency(%q<thor>, ["~> 0.19"])
      s.add_dependency(%q<aruba>, ["~> 0.6"])
      s.add_dependency(%q<cucumber>, ["~> 1.3"])
      s.add_dependency(%q<pry>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.99"])
    end
  else
    s.add_dependency(%q<parslet>, ["~> 1.7"])
    s.add_dependency(%q<thor>, ["~> 0.19"])
    s.add_dependency(%q<aruba>, ["~> 0.6"])
    s.add_dependency(%q<cucumber>, ["~> 1.3"])
    s.add_dependency(%q<pry>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.99"])
  end
end
