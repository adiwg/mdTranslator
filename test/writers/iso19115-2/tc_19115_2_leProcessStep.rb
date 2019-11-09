# MdTranslator - minitest of
# writers / iso19115_2 / class_leProcessStep

# History:
#  Stan Smith 2019-09-26 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152leProcessStep < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base


   hStep = TDClass.build_leProcessStep_full
   hLineage = TDClass.lineage
   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_processStep_complete_multi

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_leProcessStep',
                                                '//gmd:processStep[1]',
                                                '//gmd:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStep_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hStep = hIn[:metadata][:resourceLineage][0][:processStep][0]
      hStep[:processor].delete_at(1)
      hStep[:stepSource].delete_at(1)
      hStep[:stepProduct].delete_at(1)
      hStep[:reference].delete_at(1)
      hStep[:report].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_leProcessStep',
                                                '//gmd:processStep[2]',
                                                '//gmd:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStep_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hStep = hIn[:metadata][:resourceLineage][0][:processStep][0]
      hStep.delete(:stepId)
      hStep.delete(:processor)
      hStep.delete(:stepSource)
      hStep.delete(:stepProduct)
      hStep.delete(:reference)
      hStep.delete(:timePeriod)
      hStep.delete(:rationale)
      hStep.delete(:processingInformation)
      hStep[:report].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_leProcessStep',
                                                '//gmd:processStep[3]',
                                                '//gmd:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
