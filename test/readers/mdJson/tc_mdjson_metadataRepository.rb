# MdTranslator - minitest of
# reader / mdJson / module_metadataRepository

# History:
#   Stan Smith 2017-02-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadataRepository'

class TestReaderMetadataRepository < TestReaderMdJsonParent

    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MetadataRepository
    aIn = TestReaderMdJsonParent.getJson('metadataRepository.json')
    @@hIn = aIn['metadataRepository'][0]

    def test_complete_metadataRepository_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'repository', metadata[:repository]
        assert_equal 'iso19115_2', metadata[:metadataFormat]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataRepository_repository

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['repository'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataRepository_repository

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('repository')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end


    def test_empty_metadataDistribution_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['metadataFormat'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'repository', metadata[:repository]
        assert_nil metadata[:metadataFormat]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_metadataDistribution_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('metadataFormat')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'repository', metadata[:repository]
        assert_nil metadata[:metadataFormat]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_metadataDistribution_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end