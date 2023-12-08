# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / fgdc_reader

# History:
#   Stan Smith 2017-08-14 original script

require 'minitest/autorun'
require 'nokogiri'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/readers/fgdc/version'

class TestTranslatorRoundTrip < Minitest::Test

    def test_fgdc_demo_to_iso191152

        # read in fgdc demo file
        file = File.join(File.dirname(__FILE__), 'testData', 'fgdc_demo.xml')
        file = File.open(file, 'r')
        demo = file.read
        file.close

        metadata = ADIWG::Mdtranslator.translate(file: demo, reader: 'fgdc', writer: 'iso19115_2')

        refute_empty metadata
        assert_equal 'fgdc', metadata[:readerRequested]
        assert metadata[:readerStructurePass]
        assert_empty metadata[:readerStructureMessages]

    end

end

