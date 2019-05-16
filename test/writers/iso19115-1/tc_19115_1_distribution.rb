# MdTranslator - minitest of
# writers / iso19115_1 / class_distribution

# History:
#  Stan Smith 2019-04-24 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Distribution < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDistributor = TDClass.build_distributor('CID003')
   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor
   hDistribution[:distributor] << hDistributor
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_distribution_single_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor].delete_at(0)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_distribution',
                                                '//mdb:distributionInfo[1]',
                                                '//mdb:distributionInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distribution_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_distribution',
                                                '//mdb:distributionInfo[2]',
                                                '//mdb:distributionInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_distribution_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceDistribution][0][:distributor].delete_at(0)

      # elements empty
      hIn[:metadata][:resourceDistribution][0][:description] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_distribution',
                                                '//mdb:distributionInfo[3]',
                                                '//mdb:distributionInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # elements missing
      hIn[:metadata][:resourceDistribution][0].delete(:description)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_distribution',
                                                '//mdb:distributionInfo[3]',
                                                '//mdb:distributionInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
