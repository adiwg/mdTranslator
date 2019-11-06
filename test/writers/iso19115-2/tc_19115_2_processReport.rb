# MdTranslator - minitest of
# writers / iso19115_2 / class_processStepReport

# History:
#  Stan Smith 2019-09-26 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152ProcessStepReport < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hReport = TDClass.processStepReport
   hStep = TDClass.processStep
   hLineage = TDClass.lineage
   hStep[:report] << hReport
   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_processStepReport_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_processReport',
                                                '//gmi:report[1]',
                                                '//gmi:report', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStepReport_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReport = hIn[:metadata][:resourceLineage][0][:processStep][0][:report][0]
      hReport.delete(:description)
      hReport.delete(:fileType)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_processReport',
                                                '//gmi:report[2]',
                                                '//gmi:report', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processStepReport_missing_name

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReport = hIn[:metadata][:resourceLineage][0][:processStep][0][:report][0]
      hReport.delete(:description)
      hReport.delete(:name)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_processReport',
                                                '//gmi:report[3]',
                                                '//gmi:report', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3], 'WARNING: ISO-19115-2 writer: process step report name is missing: CONTEXT is process step report'

   end

end
