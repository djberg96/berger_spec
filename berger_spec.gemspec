require 'rubygems'
require 'rbconfig'

Gem::Specification.new do |gem|
  gem.name       = 'berger_spec'
  gem.version    = '1.0.0'
  gem.license    = 'Artistic 2.0'
  gem.author     = 'Daniel J. Berger'
  gem.email      = 'djberg96@gmail.com'
  gem.homepage   = 'http://www.rubyforge.org/projects/shards'
  gem.summary    = "Daniel Berger's personal test and benchmark suite for Ruby"
  gem.test_files = Dir['test/**/*.rb']
  gem.files      = Dir['**/*'].reject{ |f| f.include?('git') }

  gem.rubyforge_project = 'shards'
  gem.extra_rdoc_files  = ['README', 'SCORECARD']

  gem.description = <<-EOF
    This is a custom test suite written by Daniel Berger for Ruby. It is
    an amalgam of his own tests, tests from BFTS, rubyspec, the JRuby test
    suite and elsewhere. But mostly it's his own stuff. It also includes a
    series of benchmark suites.
  EOF

  gem.add_development_dependency('test-unit', '>= 2.1.2')
  gem.add_development_dependency('mkmf-lite')
end
