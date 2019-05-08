# MdTranslator - minitest of
# writers / iso19115_1 / class_lineage

# History:
#  Stan Smith 2019-05-08 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Lineage < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.build_lineage_full

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_lineage_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:citation].delete_at(1)
      hIn[:metadata][:resourceLineage][0][:processStep].delete_at(1)
      hIn[:metadata][:resourceLineage][0][:source].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_lineage',
                                                '//mdb:resourceLineage[1]',
                                                '//mdb:resourceLineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_lineage_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_lineage',
                                                '//mdb:resourceLineage[2]',
                                                '//mdb:resourceLineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_lineage_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hLineage = hIn[:metadata][:resourceLineage][0]

      # empty elements
      hLineage[:scope] = {}
      hLineage[:citation] = []
      hLineage[:processStep] = []
      hLineage[:source] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_lineage',
                                                '//mdb:resourceLineage[3]',
                                                '//mdb:resourceLineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hLineage.delete(:scope)
      hLineage.delete(:citation)
      hLineage.delete(:processStep)
      hLineage.delete(:source)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_lineage',
                                                '//mdb:resourceLineage[3]',
                                                '//mdb:resourceLineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
