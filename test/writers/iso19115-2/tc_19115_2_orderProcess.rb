# MdTranslator - minitest of
# writers / iso19115_2 / class_orderProcess

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152OrderProcess < TestWriter191152Parent

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

   def test_onlineResource_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_orderProcess',
                                                '//gmd:distributionOrderProcess[1]',
                                                '//gmd:distributionOrderProcess', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_onlineResource_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:orderProcess][0] = { nonElement: 'nonElement' }

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_orderProcess',
                                                '//gmd:distributionOrderProcess[2]',
                                                '//gmd:distributionOrderProcess', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
