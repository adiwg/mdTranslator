# MdTranslator - minitest of
# writers / iso19115_3 / class_legalConstraint

# History:
#  Stan Smith 2019-05-07 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151LegalConstraint < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_legalConstraint_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_legalConstraint',
                                                '//mri:resourceConstraints[1]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_legalConstraint_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = hIn[:metadata][:resourceInfo][:constraint][0][:legal]
      hCon[:accessConstraint] << 'access constraint two'
      hCon[:useConstraint] << 'use constraint two'
      hCon[:otherConstraint] << 'other constraint two'

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_legalConstraint',
                                                '//mri:resourceConstraints[2]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_legalConstraint_second

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = TDClass.build_legalConstraint
      hIn[:metadata][:resourceInfo][:constraint] << hCon

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_legalConstraint',
                                                '//mri:resourceConstraints[3]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_legalConstraint',
                                                '//mri:resourceConstraints[4]',
                                                '//mri:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_legalConstraint_useLimitation

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = hIn[:metadata][:resourceInfo][:constraint][0]
      hCon[:useLimitation] = []
      TDClass.add_useLimitation(hCon, 'use limitation one')
      TDClass.add_useLimitation(hCon, 'use limitation two')

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_legalConstraint',
                                                '//mri:resourceConstraints[5]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
