# MdTranslator - minitest of
# writers / fgdc / class_distribution

# History:
#  Stan Smith 2018-01-30 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcDistribution < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceDistribution] = []

   # distribution 1 ========================================
   hDistribution1 = TDClass.build_distribution

   # distributor 1 -----------------------------------------
   # .. 1 order process
   # .. 1 transfer option
   # .. 2 resource formats (second is lost by fgdc standard)
   # .. 2 offline and 2 online options
   hDistributor1 = TDClass.build_distributor('CID001')
   TDClass.add_orderProcess(hDistributor1)
   hTranOption1 = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTranOption1, 'format one', 'prerequisite one')
   TDClass.add_resourceFormat(hTranOption1, 'format two', 'prerequisite two')
   TDClass.add_offlineOption(hTranOption1)
   TDClass.add_offlineOption(hTranOption1)
   TDClass.add_onlineOption(hTranOption1, 'https://127.0.0.1/one')
   TDClass.add_onlineOption(hTranOption1, 'https://127.0.0.1/two')
   hDistributor1[:transferOption] << hTranOption1
   hDistribution1[:distributor] << hDistributor1

   # distributor 2 -----------------------------------------
   # custom order process
   # .. 1 order process
   hDistributor2 = TDClass.build_distributor('CID001')
   TDClass.add_orderProcess(hDistributor2)
   hDistribution1[:distributor] << hDistributor2

   # distributor 3 -----------------------------------------
   # non-digital order process
   # .. 1 order process
   # .. 1 transfer option
   # .. 1 resource format
   # .. 1 offline (note only)
   hDistributor3 = TDClass.build_distributor('CID001')
   TDClass.add_orderProcess(hDistributor3)
   hTranOption3 = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTranOption3, 'format three')
   TDClass.add_offlineOption(hTranOption3, true)
   hDistributor3[:transferOption] << hTranOption3
   hDistribution1[:distributor] << hDistributor3

   # load distribution 1
   mdHash[:metadata][:resourceDistribution] << hDistribution1

   # distribution 2 ========================================
   hDistribution2 = TDClass.build_distribution

   # distributor 4 -----------------------------------------
   # .. 2 order process
   # .. 1 transfer option
   # .. 1 resource format
   # .. 1 online options
   hDistributor4 = TDClass.build_distributor('CID001')
   TDClass.add_orderProcess(hDistributor4)
   TDClass.add_orderProcess(hDistributor4)
   hTranOption4 = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTranOption4, 'format four')
   TDClass.add_onlineOption(hTranOption4, 'https://127.0.0.1/three')
   hDistributor4[:transferOption] << hTranOption4
   hDistribution2[:distributor] << hDistributor4

   # load distribution 2
   mdHash[:metadata][:resourceDistribution] << hDistribution2

   @@mdHash = mdHash

   def test_distribution_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'distribution', './metadata/distinfo')
      assert_equal hReturn[0], hReturn[1]

   end

end
