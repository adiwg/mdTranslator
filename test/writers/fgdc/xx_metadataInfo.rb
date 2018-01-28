# MdTranslator - minitest of
# writers / fgdc / class_metadataInfo

# History:
#  Stan Smith 2018-01-27 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/writers/fgdc/version'
require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'

class TestWriterFgdcMetadataInfo < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   def test_metadataInfo_complete

      # read the fgdc reference file
      xFile = TestReaderFgdcParent.get_xml('metadataInfo')
      expect = xFile.xpath('./metainfo').to_s.squeeze(' ')

      # build mdJson in hash
      mdHash = TDClass.base

      hCon = TDClass.build_legalCon
      TDClass.add_accessConstraint('access constraint jkjkjkjkj')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Fgdc::VERSION
      schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s

      assert_equal 'mdJson', hResponseObj[:readerRequested]
      assert_equal '2.3.0', hResponseObj[:readerVersionRequested]
      assert_equal schemaVersion, hResponseObj[:readerVersionUsed]
      assert hResponseObj[:readerStructurePass]
      assert_empty hResponseObj[:readerStructureMessages]
      assert_equal 'normal', hResponseObj[:readerValidationLevel]
      assert hResponseObj[:readerValidationPass]
      assert_empty hResponseObj[:readerValidationMessages]
      assert hResponseObj[:readerExecutionPass]
      assert_empty hResponseObj[:readerExecutionMessages]
      assert_equal 'fgdc', hResponseObj[:writerRequested]
      assert_equal writerVersion, hResponseObj[:writerVersion]
      assert hResponseObj[:writerPass]
      assert_equal 'xml', hResponseObj[:writerOutputFormat]
      assert hResponseObj[:writerShowTags]
      assert_nil hResponseObj[:writerCSSlink]
      assert_equal '_000', hResponseObj[:writerMissingIdCount]
      assert_equal translatorVersion, hResponseObj[:translatorVersion]

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      got = xMetadata.xpath('./metadata').to_s.squeeze(' ')

      assert_equal expect, got

   end

end
