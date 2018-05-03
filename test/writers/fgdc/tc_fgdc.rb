# MdTranslator - minitest of
# writers / fgdc / class_fgdc

# History:
#  Stan Smith 2017-12-01 build mdJson from hash objects
#  Stan Smith 2017-11-16 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'

class TestWriterFgdcFgdc < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   def test_minimum_fgdc

      # read the fgdc reference file
      xFile = TestWriterFGDCParent.get_xml('fgdc')
      expect = xFile.xpath('./metadata').to_s.squeeze(' ')

      # build mdJson in hash
      mdHash = TDClass.base

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Fgdc::VERSION
      schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s

      assert_equal 'mdJson', hResponseObj[:readerRequested]
      assert_equal '2.4.0', hResponseObj[:readerVersionRequested]
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
