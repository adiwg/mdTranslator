# MdTranslator - minitest of
# writers / fgdc / class_keyword

# History:
#  Stan Smith 2017-11-26 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcKeyword < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # keyword one 'isoTopicCategory' is in base

   hKeyword2 = TDClass.build_keywords('NASA GCMD Earth Science Keywords','theme')
   TDClass.add_keyword(hKeyword2, 'Earth Science', '14rr-95sh74-ue17')
   TDClass.add_keyword(hKeyword2, 'Biological Classification')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword2

   hKeyword3 = TDClass.build_keywords('USGS Geographic Names Information System','place')
   TDClass.add_keyword(hKeyword3, 'Alaska')
   TDClass.add_keyword(hKeyword3, 'Colville River Delta')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword3

   hKeyword4 = TDClass.build_keywords('NGA GEOnet Names Server','place')
   TDClass.add_keyword(hKeyword4, 'Canada')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword4

   hKeyword5 = TDClass.build_keywords('Integumentary System','stratum')
   TDClass.add_keyword(hKeyword5, 'stratum corneum')
   TDClass.add_keyword(hKeyword5, 'stratum lucidum')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword5

   hKeyword6 = TDClass.build_keywords('Gregorian Calendar','temporal')
   TDClass.add_keyword(hKeyword6, 'year')
   TDClass.add_keyword(hKeyword6, 'month')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword6

   hKeyword7 = TDClass.build_keywords('thesaurus title','nonFGDC')
   TDClass.add_keyword(hKeyword7, 'one')
   TDClass.add_keyword(hKeyword7, 'two')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword7

   @@mdHash = mdHash

   def test_keyword_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'keyword', './metadata/idinfo/keywords')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_keyword_section

      # empty keyword array
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:keyword] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: keywords are missing: CONTEXT is identification section'

      # missing keyword array
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:keyword)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: keywords are missing: CONTEXT is identification section'

   end

   def test_keyword_thesaurus

      # missing keyword thesaurus
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:keyword][0].delete(:thesaurus)
      hIn[:metadata][:resourceInfo][:keyword][1].delete(:thesaurus)
      hIn[:metadata][:resourceInfo][:keyword][2].delete(:thesaurus)
      hIn[:metadata][:resourceInfo][:keyword][3].delete(:thesaurus)
      hIn[:metadata][:resourceInfo][:keyword][4].delete(:thesaurus)
      hIn[:metadata][:resourceInfo][:keyword][5].delete(:thesaurus)
      hIn[:metadata][:resourceInfo][:keyword][6].delete(:thesaurus)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: keyword set thesaurus is missing: CONTEXT is thematic keywords'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: keyword set thesaurus is missing: CONTEXT is place keywords'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: keyword set thesaurus is missing: CONTEXT is stratigraphic keywords'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: keyword set thesaurus is missing: CONTEXT is temporal keywords'

   end

end
