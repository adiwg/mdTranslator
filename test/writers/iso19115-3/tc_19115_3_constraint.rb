# MdTranslator - minitest of
# writers / iso19115_3 / class_constraint

# History:
#  Stan Smith 2019-04-18 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Constraint < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_constraint_use

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hConstraint = TDClass.build_useConstraint
      hIn[:metadata][:resourceInfo][:constraint][0] = hConstraint

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_constraint',
                                                '//mri:resourceConstraints[1]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_constraint_legal

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hConstraint = TDClass.build_legalConstraint
      hIn[:metadata][:resourceInfo][:constraint][0] = hConstraint

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_constraint',
                                                '//mri:resourceConstraints[2]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_constraint_security

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hConstraint = TDClass.build_securityConstraint
      hIn[:metadata][:resourceInfo][:constraint][0] = hConstraint

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_constraint',
                                                '//mri:resourceConstraints[3]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
