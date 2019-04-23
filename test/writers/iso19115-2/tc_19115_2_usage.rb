# MdTranslator - minitest of
# writers / iso19115_2 / class_usage

# History:
#  Stan Smith 2018-05-02 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Usage < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   mdHash = TDClass.base

   hUsage1 = TDClass.build_resourceUsage(usage:'usage one')
   mdHash[:metadata][:resourceInfo][:resourceUsage] = []
   mdHash[:metadata][:resourceInfo][:resourceUsage] << hUsage1

   @@mdHash = mdHash

   def test_resourceUsage_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_usage',
                                                '//gmd:resourceSpecificUsage[1]',
                                                '//gmd:resourceSpecificUsage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_resourceUsage_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      aUsage = hIn[:metadata][:resourceInfo][:resourceUsage]
      hUsage2 = TDClass.build_resourceUsage(usage: 'usage two')
      hTimePeriod = TDClass.build_timePeriod('TP002', 'usage two', '2018-05-02T15:12')
      hUsage2[:temporalExtent] << { timePeriod: hTimePeriod }
      hUsage2[:additionalDocumentation] << TDClass.citation
      hUsage2[:userContactInfo] << TDClass.build_responsibleParty('auditor',['CID003'])
      aUsage << hUsage2

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_usage',
                                                '//gmd:resourceSpecificUsage[2]',
                                                '//gmd:resourceSpecificUsage', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
