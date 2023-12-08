# MdTranslator - minitest of
# writers / iso19115_3 / class_processing

# History:
#  Stan Smith 2019-09-28 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Processing < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base


   hStep = TDClass.processStep
   hStep[:processingInformation] = TDClass.build_processing_full
   hLineage = TDClass.lineage
   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_processing_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_processing',
                                                '//mrl:processingInformation[1]',
                                                '//mrl:processingInformation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processing_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hInfo = hIn[:metadata][:resourceLineage][0][:processStep][0][:processingInformation]
      hInfo[:documentation].delete_at(1)
      hInfo[:algorithm].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_processing',
                                                '//mrl:processingInformation[2]',
                                                '//mrl:processingInformation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_processing_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hStep = hIn[:metadata][:resourceLineage][0][:processStep][0][:processingInformation]
      hStep.delete(:softwareReference)
      hStep.delete(:procedureDescription)
      hStep.delete(:documentation)
      hStep.delete(:runtimeParameters)
      hStep.delete(:algorithm)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_processing',
                                                '//mrl:processingInformation[3]',
                                                '//mrl:processingInformation', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
