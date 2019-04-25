# MdTranslator - minitest of
# writers / iso19115_1 / class_geographicElement

# History:
#  Stan Smith 2019-04-25 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151GeographicElement < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
   hGeoExtent[:geographicElement] = []

   @@mdHash = mdHash

   def test_geographicElement_geometry_point

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoExtent[:geographicElement] << TDClass.point

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[1]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_lineString

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoExtent[:geographicElement] << TDClass.lineString

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[2]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_polygon

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoExtent[:geographicElement] << TDClass.polygon

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[3]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_multiPoint

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoExtent[:geographicElement] << TDClass.multiPoint

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[4]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_multiLineString

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoExtent[:geographicElement] << TDClass.multiLineString

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[5]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_multiPolygon

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoExtent[:geographicElement] << TDClass.multiPolygon

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[6]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_geometryCollection

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoCollection = TDClass.geometryCollection
      hGeoCollection[:geometries] << TDClass.point
      hGeoCollection[:geometries] << TDClass.lineString
      hGeoExtent[:geographicElement] << hGeoCollection

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[7]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_feature

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoFeature = TDClass.build_feature('FEA001', 'point')
      hGeoExtent[:geographicElement] << hGeoFeature

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[8]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicElement_geometry_featureCollection

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]

      hGeoFeature1 = TDClass.build_feature('FEA001', 'point')
      hGeoFeature2 = TDClass.build_feature('FEA002', 'line')
      hFeatureColl = TDClass.build_featureCollection
      hFeatureColl[:features] << hGeoFeature1
      hFeatureColl[:features] << hGeoFeature2
      hGeoExtent[:geographicElement] << hFeatureColl

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicElement',
                                                '//gex:geographicElement[9]',
                                                '//gex:geographicElement', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
