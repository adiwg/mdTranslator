# MdTranslator - minitest of
# writers / iso19110 / class_address

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-23 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19110_test_parent'

class TestWriter19110Address < TestWriter19110Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter19110Parent.get_xml('19110_address.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_json('19110_address.json')

   # test all keys with single elements
   def test_19110_address

      xExpect = @@xFile.xpath('//gmd:contactInfo[1]')

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
      xGot = xMetadata.xpath('//gmd:contactInfo')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   # test all keys with multiple array elements
   def test_19110_address_2

      xExpect = @@xFile.xpath('//gmd:contactInfo[2]')

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
      xGot = xMetadata.xpath('//gmd:contactInfo')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   # test all keys with empty values where allowed
   def test_19110_address_3

      xExpect = @@xFile.xpath('//gmd:contactInfo[3]')

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
      xGot = xMetadata.xpath('//gmd:contactInfo')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   # test minimal address
   def test_19110_address_4

      xExpect = @@xFile.xpath('//gmd:contactInfo[3]')

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
      xGot = xMetadata.xpath('//gmd:contactInfo')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   # test empty address array
   def test_19110_address_5

      xExpect = @@xFile.xpath('//gmd:contactInfo[4]')

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
      xGot = xMetadata.xpath('//gmd:contactInfo')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   # test missing array
   def test_19110_address_6

      xExpect = @@xFile.xpath('//gmd:contactInfo[4]')

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
      xGot = xMetadata.xpath('//gmd:contactInfo')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
