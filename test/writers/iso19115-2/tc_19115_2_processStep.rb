# MdTranslator - minitest of
# writers / iso19115_2 / class_processStep

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-05 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152ProcessStep < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage

   hStep = TDClass.build_processStep('PST001','process step one')
   hStep[:timePeriod] = TDClass.build_timePeriod('TP001','step time period', nil, '2018-04-26')
   hStep[:processor] << TDClass.build_responsibleParty('processor',%w(CID003))
   hStep[:processor] << TDClass.build_responsibleParty('pointOfContact',%w(CID004))
   hStep[:stepSource] << TDClass.build_source('SRC001','step source one')
   hStep[:stepSource] << TDClass.build_source('SRC002','step source two')
   hStep[:stepProduct] << TDClass.build_source('SRC003','product source one')
   hStep[:stepProduct] << TDClass.build_source('SRC004','product source two')
   hStep[:reference] << TDClass.build_citation('step reference one')
   hStep[:reference] << TDClass.build_citation('step reference two')

   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_processStep_complete_multi

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_processStep',
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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_processStep',
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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_processStep',
                                                '//gmd:processStep[3]',
                                                '//gmd:processStep', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
