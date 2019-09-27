# MdTranslator - minitest of
# writers / iso19115_2 / class_lineage

# History:
#  Stan Smith 2018-04-25 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-05 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Lineage < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.build_lineage_full

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_lineage_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_lineage',
                                                '//gmd:lineage[1]',
                                                '//gmd:lineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_lineage_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:citation].delete_at(1)
      hIn[:metadata][:resourceLineage][0][:processStep].delete_at(1)
      hIn[:metadata][:resourceLineage][0][:source].delete_at(1)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_lineage',
                                                '//gmd:lineage[2]',
                                                '//gmd:lineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_lineage_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0].delete(:scope)
      hIn[:metadata][:resourceLineage][0].delete(:citation)
      hIn[:metadata][:resourceLineage][0].delete(:processStep)
      hIn[:metadata][:resourceLineage][0].delete(:source)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_lineage',
                                                '//gmd:lineage[3]',
                                                '//gmd:lineage', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: data quality scope is missing: CONTEXT is data quality - lineage'
   end

end
