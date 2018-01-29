# MdTranslator - minitest of
# writers / iso19115_2 / class_miMetadata

# History:
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-07 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/writers/iso19115_2/version'
require_relative 'iso19115_2_test_parent'

class TestWriter191152MIMetadata < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_miMetadata.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_json('19115_2_miMetadata.json')

   def test_19115_2_miMetadata

      xExpect = @@xFile.xpath('//gmd:MI_Metadata')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Iso19115_2::VERSION
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
      assert_equal 'iso19115_2', hResponseObj[:writerRequested]
      assert_equal writerVersion, hResponseObj[:writerVersion]
      assert hResponseObj[:writerPass]
      assert_equal 'xml', hResponseObj[:writerOutputFormat]
      assert hResponseObj[:writerShowTags]
      assert_nil hResponseObj[:writerCSSlink]
      assert_equal '_000', hResponseObj[:writerMissingIdCount]
      assert_equal translatorVersion, hResponseObj[:translatorVersion]

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:MI_Metadata')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
