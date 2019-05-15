# MdTranslator - minitest of
# writers / iso19115_1 / class_verticalExtent

# History:
#  Stan Smith 2019-05-15 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151VerticalExtent < TestWriter191151Parent

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

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_verticalExtent',
                                                '//gex:verticalElement[1]',
                                                '//gex:verticalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_vectorRepresentation_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:verticalExtent][0].delete(:description)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_verticalExtent',
                                                '//gex:verticalElement[1]',
                                                '//gex:verticalElement', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
