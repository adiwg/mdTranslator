# MdTranslator - minitest of
# writers / iso19115_2 / class_transferOptions

# History:
#  Stan Smith 2018-05-02 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TransferOptions < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTransOpt = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTransOpt, 'distribution format one')
   TDClass.add_onlineOption(hTransOpt,'http://adiwg.org/1',true)
   TDClass.add_offlineOption(hTransOpt,true)

   hDistributor = TDClass.build_distributor('CID003')
   hDistributor[:transferOption] << hTransOpt

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor

   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_transferOptions_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_transferOptions',
                                                '//gmd:distributorTransferOptions[1]',
                                                '//gmd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_transferOptions_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTransOpt = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0]
      TDClass.add_resourceFormat(hTransOpt, 'distribution format two')
      TDClass.add_onlineOption(hTransOpt,'http://adiwg.org/2',true)
      TDClass.add_offlineOption(hTransOpt,true)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_transferOptions',
                                                '//gmd:distributorTransferOptions[2]',
                                                '//gmd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_transferOptions_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0] = { nonElement: 'nonElement' }

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_transferOptions',
                                                '//gmd:distributorTransferOptions[3]',
                                                '//gmd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
