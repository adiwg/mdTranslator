# MdTranslator - minitest of
# writers / iso19115_2 / class_format

# History:
#  Stan Smith 2018-04-23 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-02 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Format < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDistributor = TDClass.build_distributor('CID003')

   hTransfer = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTransfer)
   TDClass.add_resourceFormat(hTransfer)
   hDistributor[:transferOption] << hTransfer

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_distributionFormat_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_format',
                                                '//gmd:distributorFormat[1]',
                                                '//gmd:distributorFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_format',
                                                '//gmd:distributorFormat[1]',
                                                '//gmd:distributorFormat', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distributionFormat_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:distributionFormat].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_format',
                                                '//gmd:distributorFormat[1]',
                                                '//gmd:distributorFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distributionFormat_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:distributionFormat].delete_at(1)
      hFormat = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:distributionFormat][0]
      hFormat.delete(:amendmentNumber)
      hFormat.delete(:compressionMethod)
      hFormat.delete(:technicalPrerequisite)
      hFormat[:formatSpecification].delete(:edition)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_format',
                                                '//gmd:distributorFormat[2]',
                                                '//gmd:distributorFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: format version is missing'

   end

end
