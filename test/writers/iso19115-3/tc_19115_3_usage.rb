# MdTranslator - minitest of
# writers / iso19115_3 / class_usage

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Usage < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   mdHash = TDClass.base

   hUsage1 = TDClass.build_resourceUsage(usage:'usage one')
   mdHash[:metadata][:resourceInfo][:resourceUsage] = []
   mdHash[:metadata][:resourceInfo][:resourceUsage] << hUsage1

   @@mdHash = mdHash

   def test_resourceUsage_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_usage',
                                                '//mri:resourceSpecificUsage[1]',
                                                '//mri:resourceSpecificUsage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_resourceUsage_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:resourceInfo][:resourceUsage] = []
      hUsage2 = TDClass.build_resourceUsage_full
      hIn[:metadata][:resourceInfo][:resourceUsage] << hUsage2

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_usage',
                                                '//mri:resourceSpecificUsage[2]',
                                                '//mri:resourceSpecificUsage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_resourceUsage_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # empty elements
      hUsage = hIn[:metadata][:resourceInfo][:resourceUsage][0]
      hUsage[:temporalExtent] = []
      hUsage[:userDeterminedLimitation] = ''
      hUsage[:limitationResponse] = []
      hUsage[:documentedIssue] = {}
      hUsage[:additionalDocumentation] = []
      hUsage[:userContactInfo] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_usage',
                                                '//mri:resourceSpecificUsage[3]',
                                                '//mri:resourceSpecificUsage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hUsage.delete(:temporalExtent) 
      hUsage.delete(:userDeterminedLimitation)
      hUsage.delete(:limitationResponse) 
      hUsage.delete(:documentedIssue) 
      hUsage.delete(:additionalDocumentation) 
      hUsage.delete(:userContactInfo) 

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_usage',
                                                '//mri:resourceSpecificUsage[3]',
                                                '//mri:resourceSpecificUsage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
