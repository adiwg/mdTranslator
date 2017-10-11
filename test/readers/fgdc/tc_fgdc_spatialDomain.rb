# MdTranslator - minitest of
# readers / fgdc / module_spatialDomain

# History:
#   Stan Smith 2017-08-23 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/module_coordinates'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_spatialDomain'
require_relative 'fgdc_test_parent'

class TestReaderFgdcSpatialDomain < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialDomain.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::SpatialDomain

   def test_spatialDomain_complete

      xIn = @@xDoc.xpath('./metadata/idinfo/spdom')
      hExtent = @@NameSpace.unpack(xIn, @@hResponseObj)

      refute_empty hExtent
      refute_nil hExtent[:description]
      assert_equal 1, hExtent[:geographicExtents].length
      assert_empty hExtent[:temporalExtents]
      assert_empty hExtent[:verticalExtents]

      hGeoExtent = hExtent[:geographicExtents][0]
      refute_empty hGeoExtent
      assert_equal 'spatial domain description', hGeoExtent[:description]
      assert hGeoExtent[:containsData]
      assert_empty hGeoExtent[:identifier]
      refute_empty hGeoExtent[:boundingBox]
      assert_equal 1, hGeoExtent[:geographicElements].length
      refute_empty hGeoExtent[:nativeGeoJson]
      assert_empty hGeoExtent[:computedBbox]

      hBbox = hGeoExtent[:boundingBox]
      assert_equal -166.0, hBbox[:westLongitude]
      assert_equal -74.0, hBbox[:eastLongitude]
      assert_equal 71.0, hBbox[:northLatitude]
      assert_equal 24.0, hBbox[:southLatitude]
      assert_equal 100.0, hBbox[:minimumAltitude]
      assert_equal 1000.0, hBbox[:maximumAltitude]
      assert_equal 'meters', hBbox[:unitsOfAltitude]

      hGeoElement = hGeoExtent[:geographicElements][0]
      refute_empty hGeoElement
      assert_equal 'FeatureCollection', hGeoElement[:type]
      assert_empty hGeoElement[:bbox]
      assert_equal 1, hGeoElement[:features].length
      assert_empty hGeoElement[:computedBbox]
      refute_empty hGeoElement[:nativeGeoJson]

      hFeature = hGeoElement[:features][0]
      refute_empty hFeature
      assert_equal 'Feature', hFeature[:type]
      assert_nil hFeature[:id]
      assert_empty hFeature[:bbox]
      refute_empty hFeature[:geometryObject]
      refute_empty hFeature[:properties]
      refute_empty hFeature[:nativeGeoJson]

      hGeoObject = hFeature[:geometryObject]
      assert_equal 'Polygon', hGeoObject[:type]
      assert_equal 3, hGeoObject[:coordinates].length
      refute_empty hGeoObject[:nativeGeoJson]

      hProper = hFeature[:properties]
      refute_nil hProper[:description]

      hCoords = hGeoObject[:coordinates][0]
      assert_equal 5, hCoords.length
      refute AdiwgCoordinates.is_polygon_clockwise(hCoords)

      hCoords = hGeoObject[:coordinates][1]
      assert_equal 5, hCoords.length
      assert AdiwgCoordinates.is_polygon_clockwise(hCoords)

      hCoords = hGeoObject[:coordinates][2]
      assert_equal 5, hCoords.length
      assert AdiwgCoordinates.is_polygon_clockwise(hCoords)

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
