# MdTranslator - minitest of
# writers / iso19115_1 / class_orderProcess

# History:
#  Stan Smith 2019-05-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151OrderProcess < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDistributor = TDClass.build_distributor('CID003')

   TDClass.add_orderProcess(hDistributor)

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_orderProcess_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_orderProcess',
                                                '//mrd:distributionOrderProcess[1]',
                                                '//mrd:distributionOrderProcess', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_orderProcess_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOrder = hIn[:metadata][:resourceDistribution][0][:distributor][0][:orderProcess][0]

      # empty elements
      hOrder[:fees] = ''
      hOrder[:plannedAvailability] = ''
      hOrder[:orderingInstructions] = ''
      hOrder[:turnaround] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_orderProcess',
                                                '//mrd:distributionOrderProcess[2]',
                                                '//mrd:distributionOrderProcess', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hOrder[:nonElement] = 'nonElement'
      hOrder.delete(:fees)
      hOrder.delete(:plannedAvailability)
      hOrder.delete(:orderingInstructions)
      hOrder.delete(:turnaround)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_orderProcess',
                                                '//mrd:distributionOrderProcess[2]',
                                                '//mrd:distributionOrderProcess', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
