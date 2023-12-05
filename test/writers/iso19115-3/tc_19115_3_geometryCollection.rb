# MdTranslator - minitest of
# writers / iso19115_3 / class_geometricObject

# History:
#  Stan Smith 2019-04-26 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151GeometryCollection < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:extent] << TDClass.build_extent
   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][1][:geographicExtent]
   hGeoExtent << {geographicElement: []}
   hGeoElement = hGeoExtent[0][:geographicElement]
   hGeoElement << TDClass.geometryCollection
   hGeoCollection = hGeoElement[0]
   hGeoCollection[:geometries] << TDClass.point
   hGeoCollection[:geometries] << TDClass.lineString

   @@mdHash = mdHash

   def test_geometryCollection_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_geometryCollection',
                                                '//gex:EX_Extent[1]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geometryCollection_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hElement = hIn[:metadata][:resourceInfo][:extent][1][:geographicExtent][0][:geographicElement][0]

      # empty element
      hElement[:geometries] = []
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_geometryCollection',
                                                '//gex:EX_Extent[2]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      refute hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
         'ERROR: ISO-19115-3 writer: Geometry collection has no geometries: CONTEXT is geometry collection'

   end

end
