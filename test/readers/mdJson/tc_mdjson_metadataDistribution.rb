# MdTranslator - minitest of
# reader / mdJson / module_metadataDistribution

# History:
#   Stan Smith 2017-02-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadataDistribution'

class TestReaderMetadataDistribution < TestReaderMdJsonParent

    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MetadataDistribution
    aIn = TestReaderMdJsonParent.getJson('metadataDistribution.json')
    @@hIn = aIn['metadataDistribution'][0]

    def test_complete_metadataDistribution_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'clearingHouse', metadata[:clearingHouse]
        assert_equal 'recordId', metadata[:recordId]
        assert_equal 'add', metadata[:pushMethod]
        assert_equal 'iso19115_2', metadata[:metadataFormat]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_clearingHouse

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['clearingHouse'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataDistribution_clearingHouse

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('clearingHouse')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_recordId_add

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['recordId'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'clearingHouse', metadata[:clearingHouse]
        refute metadata[:recordId]
        assert_equal 'add', metadata[:pushMethod]
        assert_equal 'iso19115_2', metadata[:metadataFormat]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataDistribution_recordId_add

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('recordId')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'clearingHouse', metadata[:clearingHouse]
        refute metadata[:recordId]
        assert_equal 'add', metadata[:pushMethod]
        assert_equal 'iso19115_2', metadata[:metadataFormat]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_recordId_update

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['recordId'] = ''
        hIn['pushMethod'] = 'update'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_pushMethod

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['pushMethod'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataDistribution_pushMethod

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('pushMethod')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_invalid_metadataDistribution_pushMethod

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['pushMethod'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_metadataFormat

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataFormat'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataDistribution_metadataFormat

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('metadataFormat')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_invalid_metadataDistribution_metadataFormat

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataFormat'] = 'invalid'
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end