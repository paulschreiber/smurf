# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "ps-smurf"
  gem.homepage = "http://github.com/paulschreiber/ps-smurf"
  gem.license = "MIT"
  gem.summary = "Rails plugin to automatically minify JS and CSS when their bundles get cached"
  gem.description = "Rails plugin to automatically minify JS and CSS when their bundles get cached."
  gem.email = "paulschreiber@gmail.com"
  gem.authors = ["Justin 'Gus' Knowlden", "Nicolas Viennot", "Ryan Grove", "Paul Schreiber"]
  # dependencies defined in Gemfile
  gem.add_development_dependency "riot"
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

require 'rcov/rcovtask'
Rcov::RcovTask.new do |test|
  test.libs << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
  test.rcov_opts << '--exclude "gems/*"'
end

task :default => :test

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "ps-smurf #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
