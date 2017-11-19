# MdTranslator - minitest of
# writers / iso19110 / class_phone

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-01 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19110_test_parent'

class TestWriter19110Phone < TestWriter19110Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter19110Parent.get_xml('19110_phone.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_file('19110_phone.json')

   def test_19110_phone_single

      xExpect = @@xFile.xpath('//gmd:phone[1]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:phone')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_phone_multiple

      xExpect = @@xFile.xpath('//gmd:phone[2]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:phone')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

   def test_19110_phone_unknown

      xExpect = @@xFile.xpath('//gmd:phone[3]')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:phone')

      assert_equal xExpect.to_s.squeeze, xGot.to_s.squeeze

   end

end
