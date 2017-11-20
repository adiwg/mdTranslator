# MdTranslator - minitest of
# writers / iso19115_2 / class_medium

# History:
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Medium < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_medium.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_file('19115_2_medium.json')

   def test_19115_2_medium_complete

      axExpect = @@xFile.xpath('//gmd:offLine')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:offLine')

      assert_equal axExpect[0].to_s.squeeze, axGot.to_s.squeeze

   end

   def test_19115_2_medium_empty_elements

      axExpect = @@xFile.xpath('//gmd:offLine')

      hJson = JSON.parse(@@mdJson)
      hJson['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]['offlineOption'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:offLine')

      assert_equal axExpect[1].to_s.squeeze, axGot.to_s.squeeze

   end

   def test_19115_2_medium_missing_elements

      axExpect = @@xFile.xpath('//gmd:offLine')

      hJson = JSON.parse(@@mdJson)
      hJson['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]['offlineOption'].delete_at(0)
      hJson['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption'][0]['offlineOption'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:offLine')

      assert_equal axExpect[2].to_s.squeeze, axGot.to_s.squeeze

   end

end
