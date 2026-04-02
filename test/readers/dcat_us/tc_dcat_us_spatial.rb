# MdTranslator - minitest of
# reader / dcat_us / module_spatial

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_spatial'

class TestReaderDcatUsSpatial < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Spatial
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_spatial_bounding_box
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, hResourceInfo[:extents].length
      geo_extents = hResourceInfo[:extents][0][:geographicExtents]
      assert_equal 1, geo_extents.length
      bbox = geo_extents[0][:boundingBox]
      refute_nil bbox
      # Fixture: "-77.119759,38.791645,-76.909393,38.995548"
      # DCAT-US spec order: minLong, minLat, maxLong, maxLat
      assert_in_delta(-77.119759, bbox[:westLongitude],  0.000001)
      assert_in_delta  38.791645, bbox[:southLatitude],  0.000001
      assert_in_delta(-76.909393, bbox[:eastLongitude],  0.000001)
      assert_in_delta  38.995548, bbox[:northLatitude],  0.000001
      assert hResponse[:readerExecutionPass]
   end

   def test_spatial_point
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['spatial'] = '-88.9718,36.52033'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, hResourceInfo[:extents].length
      geo_extent = hResourceInfo[:extents][0][:geographicExtents][0]
      assert_equal '-88.9718,36.52033', geo_extent[:description]
   end

   def test_spatial_place_name
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['spatial'] = 'Lincoln, Nebraska'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      geo_extent = hResourceInfo[:extents][0][:geographicExtents][0]
      assert_equal 'Lincoln, Nebraska', geo_extent[:description]
   end

   def test_spatial_geojson_polygon
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['spatial'] = {
         'type'        => 'Polygon',
         'coordinates' => [[[-77.12, 38.79], [-76.91, 38.79], [-76.91, 38.99], [-77.12, 38.99], [-77.12, 38.79]]]
      }
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      bbox = hResourceInfo[:extents][0][:geographicExtents][0][:boundingBox]
      refute_nil bbox
      assert_in_delta(-77.12, bbox[:westLongitude], 0.001)
      assert_in_delta(-76.91, bbox[:eastLongitude], 0.001)
   end

   def test_spatial_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('spatial')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty hResourceInfo[:extents]
   end

end
