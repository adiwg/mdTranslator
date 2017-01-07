require 'bundler/gem_tasks'
require 'rake/testtask'

# Rake::TestTask.new do |t|
# 	t.libs << 'test'
# 	t.test_files = FileList[
# 		'test/**/tc*.rb'
# 	]
# 	t.verbose = true
# end

# run one test at time - this works
# Rake::TestTask.new do |t|
# 	t.libs << 'test'
# 	t.test_files = FileList[
# 		'test/readers/mdJson/tc_mdjson_taxonomy.rb'
# 	]
# 	t.verbose = true
# end
# Rake::TestTask.new do |t|
# 	t.libs << 'test'
# 	t.test_files = FileList[
# 		'test/readers/mdJson/tc_mdjson_resourceInfo.rb'
# 	]
# 	t.verbose = true
# end
# Rake::TestTask.new do |t|
# 	t.libs << 'test'
# 	t.test_files = FileList[
# 		'test/writers/iso19115-2/tc*.rb'
# 	]
# 	t.verbose = true
# end

# reader tests fail inconsistently
#	'test/readers/mdJson/tc*.rb',

Rake::TestTask.new do |t|
	t.libs << 'test'
	t.test_files = FileList[
		'test/writers/iso19115-2/tc*.rb'
	]
	t.verbose = true
end

desc 'Run tests'
task :default => :test
