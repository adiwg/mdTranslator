# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# Stan Smith 2014-07-02 original script
# Josh Bradley 2014-09-28 updated to use test/unit

require 'minitest/autorun'
require File.join(File.expand_path('..', __FILE__),'..','lib', 'adiwg-mdtranslator.rb')

class TestTranslation < MiniTest::Unit::TestCase
    def test_ouput_success
        # read test adiwg full json test
        file = File.open(File.join(File.dirname(__FILE__),'adiwgJson_full_test_example.json'), 'r')
        jsonObj = file.read
        file.close

        # call opening module in mdTranslator
        reader = 'adiwgJson'
        writer = 'iso19115_2'
        metadata = ADIWG::Mdtranslator.translate(jsonObj,reader,writer,'normal','true')

        assert_equal('json',metadata[:readerFormat])
        assert metadata[:readerStructurePass]
        assert_equal(reader,metadata[:readerName])
        assert_equal(ADIWG::Mdtranslator::VERSION,metadata[:readerVersionUsed])
        assert metadata[:readerValidationPass]
        assert_equal(writer,metadata[:writerName])
        assert metadata[:writerPass]
        refute_nil metadata[:writerOutput]
    end
end