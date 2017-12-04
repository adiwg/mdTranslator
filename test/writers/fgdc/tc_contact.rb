# MdTranslator - minitest of
# writers / fgdc / class_contact

# History:
#   Stan Smith 2017-11-27 original script

require_relative 'fgdc_test_parent'

class TestWriterFgdcContact < TestReaderFgdcParent

   # read the mdJson 2.0
   @@mdJson = TestReaderFgdcParent.get_hash('contact')

   # TODO add schema validation test after schema update

   def test_contact_person_complete

      # read the mdJson 2.0 file
      mdFile = TestReaderFgdcParent.get_json('contact')

      # read the fgdc reference file
      xmlFile = TestReaderFgdcParent.get_xml('contact_person')

      xExpect = xmlFile.xpath('./metadata/idinfo/ptcontac')

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdFile, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/ptcontac')

      xExpect = xExpect.to_s.squeeze(' ')
      xGot = xGot.to_s.squeeze(' ')

      assert_equal xExpect, xGot

   end

   def test_contact_organization_complete

      # read the fgdc reference file
      xmlFile = TestReaderFgdcParent.get_xml('contact_organization')

      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['isOrganization'] = true
      hIn = hIn.to_json

      xExpect = xmlFile.xpath('./metadata/idinfo/ptcontac')

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/idinfo/ptcontac')

      xExpect = xExpect.to_s.squeeze(' ')
      xGot = xGot.to_s.squeeze(' ')

      assert_equal xExpect, xGot

   end

   def test_contact_person_name

      # name empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['name'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # name missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0].delete('name')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_contact_address

      # address empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'] = []
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # address missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0].delete('address')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_contact_voice_phone

      # no voice phone
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['phone'][0]['service'] = ['other']
      hIn['contact'][0]['phone'][1]['service'] = ['other']
      hIn['contact'][0]['phone'][2]['service'] = ['other']
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

   def test_contact_address_elements

      # address city empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['city'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # address city missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0].delete('city')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # address state empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['administrativeArea'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # address state missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0].delete('administrativeArea')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # address postal code empty
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0]['postalCode'] = ''
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

      # address postal code missing
      hIn = Marshal::load(Marshal.dump(@@mdJson))
      hIn['contact'][0]['address'][0].delete('postalCode')
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      refute_empty hResponseObj[:writerMessages]

   end

end
