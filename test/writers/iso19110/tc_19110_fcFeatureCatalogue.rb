# MdTranslator - minitest of
# writers / iso19110 / class_fcFeatureCatalogue

# History:
#   Stan Smith 2017-01-23 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'rexml/document'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/writers/iso19110/version'
include REXML

class TestWriter19110FeatureCatalogue < MiniTest::Test

   # read the mdJson 2.0 file
   fname = File.join(File.dirname(__FILE__), 'testData', '19110_fcFeatureCatalogue.json')
   file = File.open(fname, 'r')
   @@mdJson = file.read
   file.close

   def test_19110_featureCatalogue

      # read the ISO 19110 complete reference file
      fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_fcFeatureCatalogue0.xml')
      file = File.new(fname)
      iso_xml = Document.new(file)
      refXML = XPath.first(iso_xml, '//gfc:FC_FeatureCatalogue')

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

      metadata = hResponseObj[:writerOutput]
      iso_out = Document.new(metadata)
      checkXML = XPath.first(iso_out, '//gfc:FC_FeatureCatalogue')

      assert_equal refXML.to_s.squeeze, checkXML.to_s.squeeze

   end

   def test_19110_featureCatalogue_empty_elements

      # read the ISO 19110 empty element reference file
      fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_fcFeatureCatalogue1.xml')
      file = File.new(fname)
      iso_xml = Document.new(file)
      refXML = XPath.first(iso_xml, '//gfc:FC_FeatureCatalogue')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'].delete_at(2)
      hJson['dataDictionary'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      metadata = hResponseObj[:writerOutput]
      iso_out = Document.new(metadata)

      checkXML = XPath.first(iso_out, '//gfc:FC_FeatureCatalogue')

      assert_equal refXML.to_s.squeeze, checkXML.to_s.squeeze

   end

   def test_19110_featureCatalogue_missing_elements

      # read the ISO 19110 empty element reference file
      fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_fcFeatureCatalogue2.xml')
      file = File.new(fname)
      iso_xml = Document.new(file)
      refXML = XPath.first(iso_xml, '//gfc:FC_FeatureCatalogue')

      hJson = JSON.parse(@@mdJson)
      hJson['dataDictionary'].delete_at(0)
      hJson['dataDictionary'].delete_at(0)
      jsonIn = hJson.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      metadata = hResponseObj[:writerOutput]
      iso_out = Document.new(metadata)

      checkXML = XPath.first(iso_out, '//gfc:FC_FeatureCatalogue')

      assert_equal refXML.to_s.squeeze, checkXML.to_s.squeeze

   end

end
