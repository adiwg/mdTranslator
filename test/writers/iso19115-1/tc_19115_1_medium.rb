# MdTranslator - minitest of
# writers / iso19115_1 / class_medium

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Medium < TestWriter191151Parent

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

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_medium',
                                                '//mrd:offLine[1]',
                                                '//mrd:offLine', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_medium_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMedium = hIn[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0][:offlineOption][0]

      # empty elements
      hMedium[:mediumSpecification] = {}
      hMedium[:density] = ''
      hMedium[:units] = ''
      hMedium[:numberOfVolumes] = ''
      hMedium[:mediumFormat] = []
      hMedium[:identifier] = {}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_medium',
                                                '//mrd:offLine[2]',
                                                '//mrd:offLine', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hMedium.delete(:mediumSpecification)
      hMedium.delete(:density)
      hMedium.delete(:units)
      hMedium.delete(:numberOfVolumes)
      hMedium.delete(:mediumFormat)
      hMedium.delete(:identifier)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_medium',
                                                '//mrd:offLine[2]',
                                                '//mrd:offLine', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
