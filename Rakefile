require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
	t.libs << 'test'
	t.test_files = FileList[
		'test/readers/mdJson/v0_9/tc*.rb',
		'test/writers/iso19115_2/tc*.rb',
	]
	t.verbose = true
end

desc 'Run tests'
task :default => :test


