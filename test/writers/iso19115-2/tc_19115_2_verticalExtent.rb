# MdTranslator - minitest of
# writers / iso19115_2 / class_verticalExtent

# History:
#  Stan Smith 2018-05-03 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152VerticalExtent < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hExtent = mdHash[:metadata][:resourceInfo][:extent][0]
   hExtent[:verticalExtent] = []
   TDClass.add_verticalExtent(hExtent, 'vertical one')

   @@mdHash = mdHash

   def test_vectorRepresentation_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_verticalExtent',
                                                '//gmd:verticalElement[1]',
                                                '//gmd:verticalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_vectorRepresentation_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:verticalExtent][0].delete(:description)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_verticalExtent',
                                                '//gmd:verticalElement[1]',
                                                '//gmd:verticalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
