# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# uncomment next 2 lines to run code (not gem) ....
lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'adiwg-mdtranslator'

puts 'start test script'

# read test adiwg full json test
#file = File.open('test/mdJson_template.json', 'r')
#file = File.open('test/mdJson_min_test_example.json', 'r')
file = File.open('test/mdJson_full_test_example.json', 'r')
jsonObj = file.read
file.close

# call opening module in mdTranslator
metadata = ADIWG::Mdtranslator.translate(jsonObj,'mdJson','iso19115_2','normal','true')

# send all the output to the terminal
require 'pp'
writerOut = metadata[:writerOutput]
metadata[:writerOutput] = 'Extracted'
puts '---------------------=======================BEGIN=========================---------------------------'
pp metadata
# puts writerOut.to_s
# pp writerOut
puts '---------------------========================END==========================---------------------------'

# # test for resource path
# puts ADIWG::Mdtranslator.path_to_resources

# # test reader readme
# puts ADIWG::Mdtranslator.get_reader_readme('mdJson')
# puts '================================================='
# puts ADIWG::Mdtranslator.get_writer_readme('iso19115_2')

puts 'test script has completed'
