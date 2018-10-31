# MdTranslator - minitest of
# writers / iso19115_2 / class_taxonomicClassification

# History:
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TaxonomicClassification < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy1 = TDClass.build_taxonomy
   hTaxonomy1[:taxonomicClassification].insert(0, TDClass.build_taxonomyClassification_full)
   hTaxonomy2 = TDClass.build_taxonomy
   mdHash[:metadata][:resourceInfo][:taxonomy] = [hTaxonomy1, hTaxonomy2]


   @@mdHash = mdHash

   def test_taxonomicClassification_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomicClassification',
                                                '//gmd:taxonomy[1]',
                                                '//gmd:taxonomy', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 4, hReturn[3].length
      assert_includes hReturn[3], 'NOTICE: ISO-19115-2 writer: multiple taxonomic classifications were specified, ISO 19115-2 supports only one: CONTEXT is taxonomy'
      assert_includes hReturn[3], 'NOTICE: ISO-19115-2 writer: the first taxonomic classification was written to the metadata record: CONTEXT is taxonomy'
      assert_includes hReturn[3], 'NOTICE: ISO-19115-2 writer: multiple taxonomies were provided, ISO 19115-2 allows only one: CONTEXT is main resource'
      assert_includes hReturn[3], 'NOTICE: ISO-19115-2 writer: the first taxonomy was written to the metadata record: CONTEXT is main resource'

   end

end
