# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / fgdc_reader

# History:
#   Stan Smith 2017-08-14 original script

require 'minitest/autorun'
require 'nokogiri'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/readers/fgdc/version'

class TestFgdcReader < MiniTest::Test

    def test_fgdc_reader_badly_formed_xml

        # read in an fgdc test file with badly formed structure
        file = File.join(File.dirname(__FILE__), 'testData', 'fgdc_badForm.xml')
        file = File.open(file, 'r')
        badForm = file.read
        file.close

        metadata = ADIWG::Mdtranslator.translate(file: badForm, reader: 'fgdc')

        refute_empty metadata
        assert_equal 'fgdc', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]
        assert metadata[:readerValidationPass]
        assert_empty metadata[:readerValidationMessages]
        assert metadata[:readerExecutionPass]
        assert_empty metadata[:readerExecutionMessages]

    end

    def test_fgdc_reader_invalid_fgdc

        # read in an fgdc test file with badly formed structure
        file = File.join(File.dirname(__FILE__), 'testData', 'fgdc_invalid.xml')
        file = File.open(file, 'r')
        badForm = file.read
        file.close

        metadata = ADIWG::Mdtranslator.translate(file: badForm, reader: 'fgdc')

        refute_empty metadata
        assert_equal 'fgdc', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]
        assert metadata[:readerValidationPass]
        assert_empty metadata[:readerValidationMessages]
        assert metadata[:readerExecutionPass]
        assert_empty metadata[:readerExecutionMessages]

    end

    def test_fgdc_reader_empty_file

       metadata = ADIWG::Mdtranslator.translate(file: '{}', reader: 'fgdc')

       refute_empty metadata
       assert_equal 'fgdc', metadata[:readerRequested]
       refute metadata[:readerStructurePass]
       refute_empty metadata[:readerStructureMessages]

   end

end

