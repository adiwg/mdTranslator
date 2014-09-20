# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# 	Stan Smith 2014-07-02 original script

# uncomment next 2 lines to run code (not gem) ....
lib = File.expand_path('lib')
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'adiwg-mdtranslator'

puts 'start test script'

# read test adiwg full json test
file = File.open('test/adiwgJson_full_test_example.json', 'r')
jsonObj = file.read
file.close

# call opening module in mdTranslator
metadata = ADIWG::Mdtranslator.translate(jsonObj,'adiwgJson','iso19115_2','normal','true')

# send all the output to the terminal
require 'pp'
writerOut = metadata[:writerOutput]
metadata[:writerOutput] = 'Extracted'
puts '---------------------=======================BEGIN=========================---------------------------'
pp metadata
puts writerOut.to_s
# pp writerOut
puts '---------------------========================END==========================---------------------------'

puts 'test script has completed'
