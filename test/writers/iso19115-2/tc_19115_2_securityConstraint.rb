# MdTranslator - minitest of
# writers / iso19115_2 / class_securityConstraint

# History:
#  Stan Smith 2018-04-30 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152SecurityConstraint < TestWriter191152Parent

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_securityConstraint',
                                                '//gmd:resourceConstraints[1]',
                                                '//gmd:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_securityConstraint_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = hIn[:metadata][:resourceInfo][:constraint][1]
      hCon[:useLimitation] = []
      hCon[:security].delete(:userNote)
      hCon[:security].delete(:classificationSystem)
      hCon[:security].delete(:handlingDescription)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_securityConstraint',
                                                '//gmd:resourceConstraints[2]',
                                                '//gmd:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
