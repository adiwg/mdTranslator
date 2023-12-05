# MdTranslator - minitest of
# writers / iso19115_3 / class_associatedResource

# History:
#  Stan Smith 2019-04-16 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151AssociatedResource < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hAssRes1 = TDClass.build_associatedResource('largerWorkCitation', 'associated resource title 1')
   mdHash[:metadata][:associatedResource] = []
   mdHash[:metadata][:associatedResource] << hAssRes1

   @@mdHash = mdHash

   def test_associatedResource_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_associatedResource',
                                                '//mri:associatedResource[1]',
                                                '//mri:associatedResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_associatedResource_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hAssRes2 = TDClass.build_associatedResource('product', 'associated resource title 2')
      hIn[:metadata][:associatedResource] << hAssRes2

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_associatedResource',
                                                '//mri:associatedResource[2]',
                                                '//mri:associatedResource', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_associatedResource_elements

      # empty optional element
      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:associatedResource][0][:initiativeType] = ''
      hIn[:metadata][:associatedResource][0][:metadataCitation] = {}
      hIn[:metadata][:associatedResource][0][:resourceCitation].delete(:responsibleParty)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_associatedResource',
                                                '//mri:associatedResource[3]',
                                                '//mri:associatedResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing optional element
      hIn[:metadata][:associatedResource][0].delete(:initiativeType)
      hIn[:metadata][:associatedResource][0].delete(:metadataCitation)
      hIn[:metadata][:associatedResource][0][:resourceCitation].delete(:responsibleParty)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_associatedResource',
                                                '//mri:associatedResource[3]',
                                                '//mri:associatedResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
