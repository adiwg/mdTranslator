# MdTranslator - minitest of
# writers / iso19115_2 / class_measure

# History:
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-11-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Measure < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_measure.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_file('19115_2_measure.json')

   def test_19115_2_measure_distance

      axExpect = @@xFile.xpath('//gmd:resolution')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:resolution')

      assert_equal axExpect[0].to_s.squeeze, axGot.to_s.squeeze

   end

   def test_19115_2_measure_length

      axExpect = @@xFile.xpath('//gmd:resolution')

      hJson = JSON.parse(@@mdJson)
      hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
      hResolution['type'] = 'length'
      hResolution['unitOfMeasure'] = 'length'
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:resolution')

      assert_equal axExpect[1].to_s.squeeze, axGot.to_s.squeeze

   end

   def test_19115_2_measure_angle

      axExpect = @@xFile.xpath('//gmd:resolution')

      hJson = JSON.parse(@@mdJson)
      hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
      hResolution['type'] = 'angle'
      hResolution['unitOfMeasure'] = 'angle'
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:resolution')

      assert_equal axExpect[2].to_s.squeeze, axGot.to_s.squeeze

   end

   def test_19115_2_measure_measure

      axExpect = @@xFile.xpath('//gmd:resolution')

      hJson = JSON.parse(@@mdJson)
      hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
      hResolution['type'] = 'measure'
      hResolution['unitOfMeasure'] = 'measure'
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:resolution')

      assert_equal axExpect[3].to_s.squeeze, axGot.to_s.squeeze

   end

   def test_19115_2_measure_scale

      axExpect = @@xFile.xpath('//gmd:resolution')

      hJson = JSON.parse(@@mdJson)
      hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
      hResolution['type'] = 'scale'
      hResolution['unitOfMeasure'] = 'scale'
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:resolution')

      assert_equal axExpect[4].to_s.squeeze, axGot.to_s.squeeze

   end

end
