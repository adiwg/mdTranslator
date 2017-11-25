# MdTranslator - minitest of
# writers / iso19115_2 / class_citation

# History:
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Citation < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_citation.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_json('19115_2_citation.json')

   def test_19115_2_citation

      axExpect = @@xFile.xpath('//gmd:citation')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:citation')

      assert_equal axExpect[0].to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19115_2_citation_no_dash_1_elements

      axExpect = @@xFile.xpath('//gmd:citation')

      hJson = JSON.parse(@@mdJson)
      hCitation = hJson['metadata']['resourceInfo']['citation']
      hCitation.delete('onlineResource')
      hCitation.delete('graphic')
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:citation')

      assert_equal axExpect[0].to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19115_2_citation_empty_elements

      axExpect = @@xFile.xpath('//gmd:citation')

      hJson = JSON.parse(@@mdJson)
      hCitation = hJson['metadata']['resourceInfo']['citation']
      hCitation['alternateTitle'] = []
      hCitation['date'] = []
      hCitation['onlineResource'] = []
      hCitation['edition'] = ''
      hCitation['responsibleParty'] = []
      hCitation['presentationForm'] = []
      hCitation['identifier'] = []
      hCitation['series'] = {}
      hCitation['otherCitationDetails'] = []
      hCitation['onlineResource'] = []
      hCitation['graphic'] = []
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:citation')

      assert_equal axExpect[1].to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19115_2_citation_missing_elements

      axExpect = @@xFile.xpath('//gmd:citation')

      hJson = JSON.parse(@@mdJson)
      hCitation = hJson['metadata']['resourceInfo']['citation']
      hCitation.delete('alternateTitle')
      hCitation.delete('date')
      hCitation.delete('onlineResource')
      hCitation.delete('edition')
      hCitation.delete('responsibleParty')
      hCitation.delete('presentationForm')
      hCitation.delete('identifier')
      hCitation.delete('series')
      hCitation.delete('otherCitationDetails')
      hCitation.delete('onlineResource')
      hCitation.delete('graphic')
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:citation')

      assert_equal axExpect[1].to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
