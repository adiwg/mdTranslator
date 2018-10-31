# MdTranslator - minitest of
# writers / iso19115_2 / class_taxonomy

# History:
#  Stan Smith 2018-10-19 refactored for mdJson schema 2.6.0
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Taxonomy < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   aTaxonomy = []
   aTaxonomy << TDClass.build_taxonomy_full
   aTaxonomy << TDClass.build_taxonomy_full
   mdHash[:metadata][:resourceInfo][:taxonomy] = aTaxonomy

   # taxon keywords
   hKeyword2 = TDClass.build_keywords('fgdc taxonomy keywords','taxon')
   TDClass.add_keyword(hKeyword2, 'animals')
   TDClass.add_keyword(hKeyword2, 'vertebrates')
   TDClass.add_keyword(hKeyword2, 'birds')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword2

   hKeyword3 = TDClass.build_keywords('fgdc taxonomy keywords two','taxon')
   TDClass.add_keyword(hKeyword3, 'plants')
   TDClass.add_keyword(hKeyword3, 'grasses')
   TDClass.add_keyword(hKeyword3, 'bamboo')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword3

   @@mdHash = mdHash

   def test_taxonomicSystem_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomy',
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

   def test_taxonomicSystem_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:taxonomy].delete_at(1)
      hTaxonomy = hIn[:metadata][:resourceInfo][:taxonomy][0]
      hTaxonomy[:taxonomicSystem].delete_at(1)
      hTaxonomy.delete(:generalScope)
      hTaxonomy.delete(:identificationReference)
      hTaxonomy.delete(:observer)
      hTaxonomy.delete(:identificationCompleteness)
      hTaxonomy.delete(:voucher)
      hTaxonomy[:taxonomicClassification].delete_at(1)


      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomy',
                                                '//gmd:taxonomy[2]',
                                                '//gmd:taxonomy', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: taxonomic identification reference is missing'

   end

end
