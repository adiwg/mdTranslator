# MdTranslator - minitest of
# writers / iso19115_2 / class_miMetadata

# History:
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-02-01 original script

require 'minitest/autorun'
require 'json'
require 'date'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152MetadataDate < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_metadataDate.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_json('19115_2_metadataDate.json')

   def test_19115_2_metadataDate

      axExpect = @@xFile.xpath('//gmd:dateStamp')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:dateStamp')

      assert_equal axExpect[0].to_s.squeeze(' '), axGot.to_s.squeeze(' ')

   end

   def test_19115_2_metadataDate_missing_create

      hJson = JSON.parse(@@mdJson)
      hJson['metadata']['metadataInfo']['metadataDate'].delete_at(1)
      jsonIn = hJson.to_json
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:dateStamp').text.gsub("\n",'').strip
      today = Time.now.strftime("%Y-%m-%d")

      assert_equal today.to_s, axGot

   end

end
