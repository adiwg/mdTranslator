# MdTranslator - minitest of
# writers / iso19115_1 / class_format

# History:
#  Stan Smith 2019-04-25 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Format < TestWriter191151Parent

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

   def test_distributionFormat_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:distributionFormat].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_format',
                                                '//mrd:distributionFormat[1]',
                                                '//mrd:distributionFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distributionFormat_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_format',
                                                '//mrd:distributionFormat[1]',
                                                '//mrd:distributionFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_format',
                                                '//mrd:distributionFormat[1]',
                                                '//mrd:distributionFormat', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distributionFormat_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:distributionFormat].delete_at(1)
      hFormat = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:distributionFormat][0]

      # empty elements
      hFormat[:amendmentNumber] = ''
      hFormat[:compressionMethod] = ''
      hFormat[:technicalPrerequisite] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_format',
                                                '//mrd:distributionFormat[2]',
                                                '//mrd:distributionFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hFormat.delete(:amendmentNumber)
      hFormat.delete(:compressionMethod)
      hFormat.delete(:technicalPrerequisite)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_format',
                                                '//mrd:distributionFormat[2]',
                                                '//mrd:distributionFormat', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
