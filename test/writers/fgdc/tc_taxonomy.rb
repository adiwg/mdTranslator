# MdTranslator - minitest of
# writers / fgdc / class_taxonomy

# History:
#  Stan Smith 2018-10-19 refactored for mdJson schema 2.6.0
#  Stan Smith 2017-12-12 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcTaxonomy < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   aTaxonomy = []
   aTaxonomy << TDClass.build_taxonomy_full(true)
   aTaxonomy << TDClass.build_taxonomy_full(true)
   mdHash[:metadata][:resourceInfo][:taxonomy] = aTaxonomy

   # taxon keywords for fgdc
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

   def test_taxonomy_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'taxonomy', './metadata/idinfo/taxonomy')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

      assert hReturn[2]
      assert_equal 4, hReturn[3].length
      assert_includes hReturn[3],
                      'NOTICE: FGDC writer: multiple taxonomic classifications were specified, CSDGM supports only one'
      assert_includes hReturn[3],
                      'NOTICE: FGDC writer: the first taxonomic classification was written to the metadata record'
      assert_includes hReturn[3],
                      'NOTICE: FGDC writer: multiple taxonomies were specified, CSDGM allows only one'
      assert_includes hReturn[3],
                      'NOTICE: FGDC writer: the first taxonomy was written to the metadata record'

   end

   def test_taxonomy_complete_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      aTaxonomy = hIn[:metadata][:resourceInfo][:taxonomy]
      aTaxonomy.delete_at(1)
      aClassification = aTaxonomy[0][:taxonomicClassification]
      aClassification.delete_at(1)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

   end

   def test_taxonomy_keywords

      # taxonomy keywords missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:keyword].delete_at(1)
      hIn[:metadata][:resourceInfo][:keyword].delete_at(1)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: taxonomy keyword set is missing'

   end

   def test_taxonomy_keywordThesaurus

      # taxonomy keyword thesaurus missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:keyword][1].delete(:thesaurus)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: taxonomy keyword set thesaurus is missing'

   end

end
