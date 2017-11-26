# MdTranslator - minitest of
# writers / fgdc / class_status

# History:
#   Stan Smith 2017-11-25 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcStatus < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('series')

   # TODO add schema validation test after schema update

   def test_series_complete

      aReturn = TestReaderFgdcParent.get_complete('status', './metadata/idinfo/status')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_status_update

      # maintenance frequency empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['resourceMaintenance'] = []
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
      hIn['metadata']['resourceInfo'].delete('resourceMaintenance')
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
