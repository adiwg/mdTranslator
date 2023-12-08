# MdTranslator - minitest of
# writers / iso19115_3 / class_useConstraint

# History:
#  Stan Smith 2019-05-15 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151UseConstraint < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:constraint] << TDClass.build_useConstraint

   @@mdHash = mdHash

   def test_useConstraint_complete

      # all MD_Constraint elements are part of class_constraintCommon
      # testing is done in that class test

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_useConstraint',
                                                '//mri:resourceConstraints[1]',
                                                '//mri:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
