# MdTranslator - minitest of
# reader / mdJson / module_coordinates

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-10 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_geographicExtent'

class TestReaderMdJsonComputedBox < TestReaderMdJsonParent

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::GeographicExtent
    aIn = TestReaderMdJsonParent.getJson('computedBbox.json')
    @@aIn = aIn['geographicExtent']

    # test all East coordinates
    # all GeoJSON structures are tested in this input
    def test_bbox_east

        hIn = @@aIn[0]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal 100.0, metadata[0]
        assert_equal 0.0, metadata[1]
        assert_equal 105.0, metadata[2]
        assert_equal 3.0, metadata[3]

    end

    # test all West coordinates
    def test_bbox_west

        hIn = @@aIn[1]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal -179.0, metadata[0]
        assert_equal 61.0, metadata[1]
        assert_equal -48.0, metadata[2]
        assert_equal 65.0, metadata[3]

    end

    # test more East coordinates
    def test_bbox_more_east

        hIn = @@aIn[2]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal 148.0, metadata[0]
        assert_equal 61.0, metadata[1]
        assert_equal -177.0, metadata[2]
        assert_equal 65.0, metadata[3]

    end

    # test more West coordinates
    def test_bbox_more_west

        hIn = @@aIn[3]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal 178.0, metadata[0]
        assert_equal 61.0, metadata[1]
        assert_equal -150.0, metadata[2]
        assert_equal 65.0, metadata[3]

    end

    # test span meridian coordinates
    def test_bbox_span_meridian

        hIn = @@aIn[4]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal -35.0, metadata[0]
        assert_equal 61.0, metadata[1]
        assert_equal 48.0, metadata[2]
        assert_equal 65.0, metadata[3]

    end

    # test southern hemisphere coordinates
    def test_bbox_southern_hemisphere

        hIn = @@aIn[5]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal -179.0, metadata[0]
        assert_equal -65.0, metadata[1]
        assert_equal -48.0, metadata[2]
        assert_equal -61.0, metadata[3]

    end

    # test span equator coordinates
    def test_bbox_span_equator

        hIn = @@aIn[6]
        hTest = Marshal::load(Marshal.dump(hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        aInternal = @@NameSpace.unpack(hTest, hResponse)
        metadata = aInternal[:geographicElement][:computedBbox]

        assert_equal 4, metadata.length
        assert_equal -179.0, metadata[0]
        assert_equal -65.0, metadata[1]
        assert_equal -48.0, metadata[2]
        assert_equal 62.45, metadata[3]

    end

end
