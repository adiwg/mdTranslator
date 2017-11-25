# MdTranslator - minitest of
# writers / fgdc / class_description

# History:
#   Stan Smith 2017-11-22 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcDescription < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('description')

   # TODO add schema validation test after schema update

   def test_description_complete

      aReturn = TestReaderFgdcParent.get_complete('description', './metadata/idinfo/descript')
      assert_equal aReturn[0], aReturn[1]

   end

   def test_description_purpose

      # purpose empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['purpose'] = ''
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
      hIn['metadata']['resourceInfo'].delete('purpose')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_description_elements

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo']['supplementalInfo'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['metadata']['resourceInfo'].delete('supplementalInfo')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])

      refute_empty xMetadata.to_s
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

   end

end
