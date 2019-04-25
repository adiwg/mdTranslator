# MdTranslator - minitest of
# writers / iso19115_1 / class_extent

# History:
#  Stan Smith 2019-04-24 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Feature < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:extent] << TDClass.build_extent

   @@mdHash = mdHash

   def test_feature_point

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << TDClass.point
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[1]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_lineString

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << TDClass.lineString
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[2]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_polygon

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << TDClass.polygon
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[3]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_multiPoint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << TDClass.multiPoint
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[4]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_multiLineString

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << TDClass.multiLineString
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[5]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_multiPolygon

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << TDClass.multiPolygon
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[6]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_geometryCollection

      collection = {
         "type": "GeometryCollection",
         "bbox": [-10.0, -10.0, 10.0, 10.0],
         "geometries": [
            {
               "type": "Point",
               "coordinates": [100.0, 0.0]
            },
            {
               "type": "LineString",
               "coordinates": [
                  [101.0, 0.0],
                  [102.0, 1.0]
               ]
            }
         ]
      }

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << collection
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_feature',
                                                '//gex:EX_Extent[7]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end
   
end
