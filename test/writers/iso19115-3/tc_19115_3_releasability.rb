# MdTranslator - minitest of
# writers / iso19115_3 / class_releasability

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Releasability < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:constraint][0] = TDClass.constraint

   @@mdHash = mdHash

   def test_releasability_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_releasability',
                                                '//mco:releasability[1]',
                                                '//mco:releasability', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_releasability_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hRelease = hIn[:metadata][:resourceInfo][:constraint][0][:releasability]

      # empty elements
      hRelease[:statement] = ''
      hRelease[:disseminationConstraint] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_releasability',
                                                '//mco:releasability[2]',
                                                '//mco:releasability', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hRelease.delete(:statement)
      hRelease.delete(:disseminationConstraint)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_releasability',
                                                '//mco:releasability[2]',
                                                '//mco:releasability', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_releasability_elements_2

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hRelease = hIn[:metadata][:resourceInfo][:constraint][0][:releasability]

      # empty elements
      hRelease[:addressee] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_releasability',
                                                '//mco:releasability[3]',
                                                '//mco:releasability', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hRelease.delete(:addressee)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_releasability',
                                                '//mco:releasability[3]',
                                                '//mco:releasability', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
