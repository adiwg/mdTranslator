# MdTranslator - minitest of
# writers / iso19110 / class_onlineResource

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-01 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19110_test_parent'

class TestWriter19110OnlineResource < TestWriter19110Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter19110Parent.get_xml('19110_onlineResource.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_json('19110_onlineResource.json')

   def test_19110_onlineResource_single

      xExpect = @@xFile.xpath('//gmd:onlineResource[1]')

      hJson = JSON.parse(@@mdJson)
      hJson['contact'][0]['onlineResource'].delete_at(1)
      hJson['contact'][0]['onlineResource'].delete_at(1)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:onlineResource')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19110_onlineResource_empty_elements

      xExpect = @@xFile.xpath('//gmd:onlineResource[2]')

      hJson = JSON.parse(@@mdJson)
      hJson['contact'][0]['onlineResource'].delete_at(0)
      hJson['contact'][0]['onlineResource'].delete_at(1)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:onlineResource')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19110_onlineResource_missing_elements

      xExpect = @@xFile.xpath('//gmd:onlineResource[3]')

      hJson = JSON.parse(@@mdJson)
      hJson['contact'][0]['onlineResource'].delete_at(0)
      hJson['contact'][0]['onlineResource'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:onlineResource')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
