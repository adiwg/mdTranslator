require 'minitest/autorun'
require_relative '../../lib/adiwg/mdtranslator'

file = File.join(File.dirname(__FILE__), 'testData', 'fgdc_demo.xml')
file = File.open(file, 'r')
demo = file.read
file.close

metadata = ADIWG::Mdtranslator.translate(file: demo, reader: 'fgdc', writer: 'dcatusJson')

hJsonOut = JSON.pretty_generate(JSON.parse(metadata[:writerOutput]))

puts hJsonOut

# File.write("output_file_dcatus_mytest.json", hJsonOut)

