# MdTranslator - minitest of
# writers / fgdc / class_citation

# History:
#   Stan Smith 2017-11-17 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcCitation < TestReaderFgdcParent

   # read the mdJson 2.0 file
   @@mdJson = TestReaderFgdcParent.get_json('citation')

   def test_citation_complete

      aReturn = TestReaderFgdcParent.get_complete('citation', './metadata/idinfo/citation')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_citation_originator_empty

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['responsibleParty'] = []
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_citation_originator_missing

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation'].delete('responsibleParty')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_citation_publication_date_format

      # year only
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['date'][1]['date'] = '2014'
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubdate').text
      xNot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubtime').text

      assert_equal '2014', xGot
      assert_empty xNot

      # year-month only
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['date'][1]['date'] = '2015-11'
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubdate').text
      xNot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubtime').text

      assert_equal '2015-11', xGot
      assert_empty xNot

      # year-month-day only
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['date'][1]['date'] = '2016-12-25'
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/citation/citeinfo/pubdate').text

      assert_equal '2016-12-25', xGot
      assert_empty xNot

   end

   def test_citation_publication_date_empty

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['date'] = []
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_citation_publication_date_missing

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation'].delete('date')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

end
