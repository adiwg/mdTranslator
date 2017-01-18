# MdTranslator - minitest of
# reader / mdJson / module_transferOption

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_transferOption'

class TestReaderMdJsonTransferOption < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TransferOption
    aIn = TestReaderMdJsonParent.getJson('transferOption.json')
    @@hIn = aIn['transferOption'][0]

    def test_complete_transferOption_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'unitsOfDistribution', metadata[:unitsOfDistribution]
        assert_equal 9.9, metadata[:transferSize]
        assert_equal 2, metadata[:onlineOptions].length
        assert_equal 2, metadata[:offlineOptions].length
        refute_empty metadata[:transferFrequency]
        assert_equal 2, metadata[:distributionFormats].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_transferOption_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['transferSize'] = ''
        hIn['unitsOfDistribution'] = ''
        hIn['onlineOption'] = []
        hIn['offlineOption'] = []
        hIn['transferFrequency'] = {}
        hIn['distributionFormat'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:unitsOfDistribution]
        assert_nil metadata[:transferSize]
        assert_empty metadata[:onlineOptions]
        assert_empty metadata[:offlineOptions]
        assert_empty metadata[:transferFrequency]
        assert_empty metadata[:distributionFormats]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_transferOption_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('unitsOfDistribution')
        hIn.delete('transferSize')
        hIn.delete('onlineOption')
        hIn.delete('offlineOption')
        hIn.delete('transferFrequency')
        hIn.delete('distributionFormat')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:unitsOfDistribution]
        assert_nil metadata[:transferSize]
        assert_empty metadata[:onlineOptions]
        assert_empty metadata[:offlineOptions]
        assert_empty metadata[:transferFrequency]
        assert_empty metadata[:distributionFormats]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_transferOption_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
