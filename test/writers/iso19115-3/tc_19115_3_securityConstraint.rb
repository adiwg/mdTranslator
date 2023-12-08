# MdTranslator - minitest of
# writers / iso19115_3 / class_securityConstraint

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151SecurityConstraint < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hCon = TDClass.build_securityConstraint
   TDClass.add_useLimitation(hCon, 'use limitation one')
   TDClass.add_useLimitation(hCon, 'use limitation two')
   mdHash[:metadata][:resourceInfo][:constraint] << hCon

   @@mdHash = mdHash

   def test_securityConstraint_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_securityConstraint',
                                                '//mri:resourceConstraints[1]',
                                                '//mri:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_securityConstraint_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = hIn[:metadata][:resourceInfo][:constraint][1]
      hCon[:useLimitation] = []
      hCon[:security][:userNote] = ''
      hCon[:security][:classificationSystem] = ''
      hCon[:security][:handlingDescription] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_securityConstraint',
                                                '//mri:resourceConstraints[2]',
                                                '//mri:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = hIn[:metadata][:resourceInfo][:constraint][1]
      hCon[:useLimitation] = []
      hCon[:security].delete(:userNote)
      hCon[:security].delete(:classificationSystem)
      hCon[:security].delete(:handlingDescription)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_securityConstraint',
                                                '//mri:resourceConstraints[2]',
                                                '//mri:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
