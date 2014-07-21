# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# 	Stan Smith 2014-07-02 original script

# to run local code ...
# lib = File.expand_path('lib')
# $LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# to run gem ...
require 'adiwg/mdtranslator'

puts 'start test script'

# read test adiwg version 1 json example
file = File.open('test/adiwg_1_full_test_example.json', 'r')
jsonObj = file.read
file.close

# call opening module in mdTranslator
metadata = ADIWG::Mdtranslator.translate(jsonObj)

puts '---------------------=======================BEGIN=========================---------------------------'
puts metadata.to_s
puts '---------------------========================END==========================---------------------------'
puts 'test script has completed'
