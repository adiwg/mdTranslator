# MdTranslator - minitest of
# writers / iso19115_1 / class_constraintCommon

# History:
#  Stan Smith 2019-04-18 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Constraint < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base
   mdHash[:metadata][:resourceInfo][:constraint][0] = TDClass.constraint

   @@mdHash = mdHash

   def test_constraintCommon_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_constraintCommon',
                                                '//mri:resourceConstraints[1]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_constraintCommon_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:constraint][0][:useLimitation] = []
      hIn[:metadata][:resourceInfo][:constraint][0][:scope] = {}
      hIn[:metadata][:resourceInfo][:constraint][0][:graphic] = []
      hIn[:metadata][:resourceInfo][:constraint][0][:reference] = []
      hIn[:metadata][:resourceInfo][:constraint][0][:releasability] = {}
      hIn[:metadata][:resourceInfo][:constraint][0][:responsibleParty] = []
      hIn[:metadata][:resourceInfo][:constraint][0][:legal] = {}
      hIn[:metadata][:resourceInfo][:constraint][0][:security] = {}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_constraintCommon',
                                                '//mri:resourceConstraints[2]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn[:metadata][:resourceInfo][:constraint][0][:nonElement] = 'nonElement'
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:useLimitation)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:scope)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:graphic)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:reference)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:releasability)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:responsibleParty)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:legal)
      hIn[:metadata][:resourceInfo][:constraint][0].delete(:security)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_constraintCommon',
                                                '//mri:resourceConstraints[2]',
                                                '//mri:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
