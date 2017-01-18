# MdTranslator - minitest of
# reader / mdJson / module_extent

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_extent'

class TestReaderMdJsonExtent < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Extent
    aIn = TestReaderMdJsonParent.getJson('extent.json')
    @@hIn = aIn['extent'][0]

    def test_complete_extent_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'description', metadata[:description]
        assert_equal 2, metadata[:geographicExtents].length
        assert_equal 2, metadata[:temporalExtents].length
        assert_equal 2, metadata[:verticalExtents].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_extent_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end