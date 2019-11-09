# MdTranslator - minitest of
# writers / iso19115_1 / class_algorithm

# History:
#  Stan Smith 2019-09-28 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Algorithm < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hAlgorithm = TDClass.algorithm
   hProcessing = TDClass.processing
   hStep = TDClass.processStep
   hLineage = TDClass.lineage
   hProcessing[:algorithm] << hAlgorithm
   hStep[:processingInformation] = hProcessing
   hLineage[:processStep] << hStep
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_algorithm_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_algorithm',
                                                '//mrl:algorithm[1]',
                                                '//mrl:algorithm', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_algorithm_missing_citation

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAlgorithm = hIn[:metadata][:resourceLineage][0][:processStep][0][:processingInformation][:algorithm][0]
      hAlgorithm.delete(:citation)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_algorithm',
                                                '//mrl:algorithm[2]',
                                                '//mrl:algorithm', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-1 writer: algorithm citation is missing: CONTEXT is resource lineage process step PS001 processing algorithm'

   end

   def test_algorithm_missing_description

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hAlgorithm = hIn[:metadata][:resourceLineage][0][:processStep][0][:processingInformation][:algorithm][0]
      hAlgorithm.delete(:description)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_algorithm',
                                                '//mrl:algorithm[3]',
                                                '//mrl:algorithm', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-1 writer: algorithm description is missing: CONTEXT is resource lineage process step PS001 processing algorithm'

   end

end
