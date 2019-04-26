# MdTranslator - minitest of
# writers / iso19115_1 / class_geographicElement

# History:
#  Stan Smith 2019-04-26 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151GeographicExtent < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hExtent = mdHash[:metadata][:resourceInfo][:extent][0]
   hExtent[:geographicExtent] = []
   TDClass.add_geographicExtent(hExtent)
   hExtent[:geographicExtent][0][:geographicElement] << TDClass.point

   @@mdHash = mdHash

   def test_geographicExtent_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicExtent',
                                                '//gex:EX_Extent[1]',
                                                '//gex:EX_Extent', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicExtent_boundingBox

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
      hGeoExtent[:containsData] = false
      hGeoExtent[:identifier] = {}
      hGeoExtent[:geographicElement] = []
      hGeoExtent[:description] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicExtent',
                                                '//gex:EX_Extent[2]',
                                                '//gex:EX_Extent', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicExtent_description

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
      hGeoExtent[:containsData] = false
      hGeoExtent[:boundingBox] = {}
      hGeoExtent[:geographicElement] = []
      hGeoExtent[:description] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicExtent',
                                                '//gex:EX_Extent[3]',
                                                '//gex:EX_Extent', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_geographicExtent_point

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hGeoExtent = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
      hGeoExtent[:containsData] = false
      hGeoExtent[:identifier] = {}
      hGeoExtent[:boundingBox] = {}
      hGeoExtent[:description] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_geographicExtent',
                                                '//gex:EX_Extent[4]',
                                                '//gex:EX_Extent', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
