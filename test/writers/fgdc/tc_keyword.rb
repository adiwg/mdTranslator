# MdTranslator - minitest of
# writers / fgdc / class_keyword

# History:
#   Stan Smith 2017-11-26 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcKeyword < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('keyword')

   # TODO add schema validation test after schema update

   def test_keyword_complete

      aReturn = TestReaderFgdcParent.get_complete('keyword', './metadata/idinfo/keywords')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_keyword_section

      # empty keyword array
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['keyword'] = []
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # missing keyword array
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo'].delete('keyword')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_keyword_thesaurus

      # missing keyword thesaurus
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['keyword'].delete_at(0)
      hIn['metadata']['resourceInfo']['keyword'].delete_at(0)
      hIn['metadata']['resourceInfo']['keyword'].delete_at(0)
      hIn['metadata']['resourceInfo']['keyword'].delete_at(0)
      hIn['metadata']['resourceInfo']['keyword'].delete_at(0)
      hIn['metadata']['resourceInfo']['keyword'].delete_at(0)
      hIn['metadata']['resourceInfo']['keyword'][0].delete('thesaurus')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

end
