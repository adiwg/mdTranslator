# MdTranslator - minitest of
# writers / iso19115_3 / class_distributor

# History:
#  Stan Smith 2019-04-24 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Distributor < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDistributor = TDClass.build_distributor('CID003')

   TDClass.add_orderProcess(hDistributor)
   TDClass.add_orderProcess(hDistributor)

   hTransfer = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTransfer)
   hDistributor[:transferOption] << hTransfer
   hDistributor[:transferOption] << hTransfer

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_distributor_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hDistributor = hIn[:metadata][:resourceDistribution][0][:distributor][0]
      hDistributor[:orderProcess] = []
      hDistributor[:transferOption] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_distributor',
                                                '//mrd:distributor[1]',
                                                '//mrd:distributor', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distributor_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hDistributor = hIn[:metadata][:resourceDistribution][0][:distributor][0]
      hDistributor[:orderProcess].delete_at(0)
      hDistributor[:transferOption].delete_at(0)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_distributor',
                                                '//mrd:distributor[2]',
                                                '//mrd:distributor', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distributor_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_distributor',
                                                '//mrd:distributor[3]',
                                                '//mrd:distributor', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
