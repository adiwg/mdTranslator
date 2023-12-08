# MdTranslator - minitest of
# writers / iso19115_3 / class_extent

# History:
#  Stan Smith 2019-04-24 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Extent < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hExtent = TDClass.build_extent
   mdHash[:metadata][:resourceInfo][:extent] << hExtent

   @@mdHash = mdHash

   def test_extent_complete_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_extent',
                                                '//gex:EX_Extent[1]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_extent_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hExtent = hIn[:metadata][:resourceInfo][:extent][1]
      TDClass.add_geographicExtent(hExtent)
      TDClass.add_temporalExtent(hExtent,'TI001','instant','2018-04-20T16:46')
      TDClass.add_verticalExtent(hExtent)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_extent',
                                                '//gex:EX_Extent[2]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_extent_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hExtent = hIn[:metadata][:resourceInfo][:extent][1]
      TDClass.add_geographicExtent(hExtent)
      TDClass.add_temporalExtent(hExtent,'TI001','instant','2018-04-20T16:46')
      TDClass.add_temporalExtent(hExtent,'TP001','period','2018-04-20T16:46')
      TDClass.add_verticalExtent(hExtent)
      TDClass.add_verticalExtent(hExtent)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_extent',
                                                '//gex:EX_Extent[3]',
                                                '//gex:EX_Extent', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
