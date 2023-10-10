# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / sbJson_reader

# History:
#   Stan Smith 2017-06-12 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/readers/sbJson/version'

class TestSbJsonReader < Minitest::Test

   def test_sbJson_reader_invalid_sbJson

       # read in an mdJson 2.x test file with invalid structure
       file = File.join(File.dirname(__FILE__), 'testData', 'sbJson_invalid.json')
       file = File.open(file, 'r')
       jsonInvalid = file.read
       file.close

       metadata = ADIWG::Mdtranslator.translate(file: jsonInvalid, reader: 'sbJson')

       refute_empty metadata
       assert_equal 'sbJson', metadata[:readerRequested]
       refute metadata[:readerStructurePass]
       refute_empty metadata[:readerStructureMessages]
       assert metadata[:readerValidationPass]
       assert_empty metadata[:readerValidationMessages]
       assert metadata[:readerExecutionPass]
       assert_empty metadata[:readerExecutionMessages]

   end

   def test_sbJson_reader_empty_sbJson

       metadata = ADIWG::Mdtranslator.translate(file: '{}', reader: 'sbJson')

       refute_empty metadata
       assert_equal 'sbJson', metadata[:readerRequested]
       refute metadata[:readerStructurePass]
       refute_empty metadata[:readerStructureMessages]

   end

end

