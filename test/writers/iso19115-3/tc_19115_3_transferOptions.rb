# MdTranslator - minitest of
# writers / iso19115_3 / class_transferOptions

# History:
#  Stan Smith 2019-05-15 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151TransferOptions < TestWriter191151Parent

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

   def test_transferOptions_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_transferOptions',
                                                '//mrd:distributorTransferOptions[1]',
                                                '//mrd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_transferOptions_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTransOpt = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0]
      TDClass.add_resourceFormat(hTransOpt, 'distribution format two')
      TDClass.add_onlineOption(hTransOpt,'http://adiwg.org/2',true)
      TDClass.add_offlineOption(hTransOpt,true)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_transferOptions',
                                                '//mrd:distributorTransferOptions[2]',
                                                '//mrd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_transferOptions_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # empty elements
      hOption = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0]
      hOption[:nonElement] = 'nonElement'
      hOption[:transferSize] = ''
      hOption[:unitsOfDistribution] = ''
      hOption[:onlineOption] = []
      hOption[:offlineOption] = []
      hOption[:transferFrequency] = ''
      hOption[:distributionFormat] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_transferOptions',
                                                '//mrd:distributorTransferOptions[3]',
                                                '//mrd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0] = { nonElement: 'nonElement' }

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_transferOptions',
                                                '//mrd:distributorTransferOptions[3]',
                                                '//mrd:distributorTransferOptions', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
