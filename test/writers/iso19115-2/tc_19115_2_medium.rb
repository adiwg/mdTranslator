# MdTranslator - minitest of
# writers / iso19115_2 / class_medium

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-22 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Medium < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDistributor = TDClass.build_distributor('CID003')

   hTransfer = TDClass.build_transferOption
   TDClass.add_offlineOption(hTransfer)
   hDistributor[:transferOption] << hTransfer

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_medium_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_medium',
                                                '//gmd:offLine[1]',
                                                '//gmd:offLine', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_medium_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMedium = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:offlineOption][0]
      hMedium.delete(:mediumSpecification)
      hMedium.delete(:density)
      hMedium.delete(:units)
      hMedium.delete(:numberOfVolumes)
      hMedium.delete(:mediumFormat)
      hMedium.delete(:identifier)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_medium',
                                                '//gmd:offLine[2]',
                                                '//gmd:offLine', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
