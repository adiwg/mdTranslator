# MdTranslator - minitest of
# writers / fgdc / class_series

# History:
#   Stan Smith 2017-11-22 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcPublisher < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_json('series')

   def test_series_complete

      aReturn = TestReaderFgdcParent.get_complete('series', './metadata/idinfo/citation/citeinfo/serinfo')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_series_name

      # name empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['series']['seriesName'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # name missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['series'].delete('seriesName')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_series_issue

      # issue empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['series']['seriesIssue'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # issue missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['citation']['series'].delete('seriesIssue')
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
