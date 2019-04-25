# MdTranslator - minitest of
# writers / iso19115_2 / class_extent

# History:
#  Stan Smith 2019-04-25 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Feature < TestWriter191152Parent

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
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[1]',
                                                '//gmd:EX_Extent', 1)

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
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[2]',
                                                '//gmd:EX_Extent', 1)

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
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[3]',
                                                '//gmd:EX_Extent', 1)

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
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[4]',
                                                '//gmd:EX_Extent', 1)

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
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[5]',
                                                '//gmd:EX_Extent', 1)

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
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[6]',
                                                '//gmd:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_feature_geometryCollection

      hGeoCollection = TDClass.geometryCollection
      hGeoCollection[:geometries] << TDClass.point
      hGeoCollection[:geometries] << TDClass.lineString

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent]
      hGeoExtent << {geographicElement: []}
      hGeoElement = hGeoExtent[0][:geographicElement]
      hGeoElement << hGeoCollection
      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_feature',
                                                '//gmd:EX_Extent[7]',
                                                '//gmd:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
