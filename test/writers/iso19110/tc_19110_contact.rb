# MdTranslator - minitest of
# writers / iso19110 / class_contact

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-23 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19110_test_parent'

class TestWriter19110Contact < TestWriter19110Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter19110Parent.get_xml('19110_contact.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_file('19110_contact.json')

   def test_19110_contact_individual_complete

      xExpect = @@xFile.xpath('//gfc:producer[1]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:producer')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_contact_organization_complete

      xExpect = @@xFile.xpath('//gfc:producer[2]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(2)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(2)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(2)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(2)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:producer')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_contact_multiple_elements

      xExpect = @@xFile.xpath('//gfc:producer[3]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(3)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(3)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(3)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:producer')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_contact_email_only

      xExpect = @@xFile.xpath('//gfc:producer[4]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(4)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(4)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:producer')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_contact_empty_elements

      xExpect = @@xFile.xpath('//gfc:producer[5]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(5)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:producer')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_contact_missing_elements

      xExpect = @@xFile.xpath('//gfc:producer[6]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:producer')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

end
