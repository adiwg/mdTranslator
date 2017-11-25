# MdTranslator - minitest of
# writers / iso19110 / class_fcFeatureCatalogue

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-23 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/writers/iso19110/version'
require_relative 'iso19110_test_parent'

class TestWriter19110FeatureCatalogue < TestWriter19110Parent

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_json('19110_fcFeatureCatalogue.json')

   def test_19110_featureCatalogue

      # read the ISO 19110 complete reference file
      xFile = TestWriter19110Parent.get_xml('19110_fcFeatureCatalogue0.xml')
      xExpect = xFile.xpath('//gfc:FC_FeatureCatalogue')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'].delete_at(1)
      hJson['dataDictionary'].delete_at(1)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Iso19110::VERSION
      schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s

      assert_equal 'mdJson', hResponseObj[:readerRequested]
      assert_equal '2.0.0', hResponseObj[:readerVersionRequested]
      assert_equal schemaVersion, hResponseObj[:readerVersionUsed]
      assert hResponseObj[:readerStructurePass]
      assert_empty hResponseObj[:readerStructureMessages]
      assert_equal 'normal', hResponseObj[:readerValidationLevel]
      assert hResponseObj[:readerValidationPass]
      assert_empty hResponseObj[:readerValidationMessages]
      assert hResponseObj[:readerExecutionPass]
      assert_empty hResponseObj[:readerExecutionMessages]
      assert_equal 'iso19110', hResponseObj[:writerRequested]
      assert_equal writerVersion, hResponseObj[:writerVersion]
      assert hResponseObj[:writerPass]
      assert_equal 'xml', hResponseObj[:writerOutputFormat]
      assert hResponseObj[:writerShowTags]
      assert_nil hResponseObj[:writerCSSlink]
      assert_equal '_000', hResponseObj[:writerMissingIdCount]
      assert_equal translatorVersion, hResponseObj[:translatorVersion]

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:FC_FeatureCatalogue')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19110_featureCatalogue_empty_elements

      # read the ISO 19110 complete reference file
      xFile = TestWriter19110Parent.get_xml('19110_fcFeatureCatalogue1.xml')
      xExpect = xFile.xpath('//gfc:FC_FeatureCatalogue')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'].delete_at(2)
      hJson['dataDictionary'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:FC_FeatureCatalogue')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

   def test_19110_featureCatalogue_missing_elements

      # read the ISO 19110 complete reference file
      xFile = TestWriter19110Parent.get_xml('19110_fcFeatureCatalogue2.xml')
      xExpect = xFile.xpath('//gfc:FC_FeatureCatalogue')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'].delete_at(0)
      hJson['dataDictionary'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gfc:FC_FeatureCatalogue')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
