# MdTranslator - minitest of
# writers / iso19115_2 / class_legalConstraint

# History:
#  Stan Smith 2018-04-24 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-04 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152LegalConstraint < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_legalConstraint_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_legalConstraint',
                                                '//gmd:resourceConstraints[1]',
                                                '//gmd:resourceConstraints', 0)

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_legalConstraint',
                                                '//gmd:resourceConstraints[2]',
                                                '//gmd:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_legalConstraint_second

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hCon = TDClass.build_legalConstraint
      hIn[:metadata][:resourceInfo][:constraint] << hCon

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_legalConstraint',
                                                '//gmd:resourceConstraints[3]',
                                                '//gmd:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_legalConstraint',
                                                '//gmd:resourceConstraints[4]',
                                                '//gmd:resourceConstraints', 1)

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_legalConstraint',
                                                '//gmd:resourceConstraints[5]',
                                                '//gmd:resourceConstraints', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
