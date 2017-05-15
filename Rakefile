require 'bundler/gem_tasks'
require 'rake/testtask'

# Rake::TestTask.new do |t|
# 	t.libs << 'test'
# 	t.test_files = FileList[
# 		'test/readers/mdJson/tc*.rb',
# 		'test/writers/iso19115-2/tc*.rb',
# 		'test/writers/iso19110/tc*.rb',
# 		'test/writers/mdJson/tc*.rb',
# 		'test/writers/sbJson/tc*.rb',
# 		'test/translator/tc*.rb'
# 	]
# 	t.verbose = true
# end

Rake::TestTask.new do |t|
	t.libs << 'test'
	t.test_files = FileList[
		'test/writers/sbJson/tc*.rb'
	]
	t.verbose = true
end

desc 'Run tests'
task :default => :test
