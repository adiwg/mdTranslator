# MdTranslator - minitest of
# writers / iso19115_1 / class_miMetadata

# History:
#  Stan Smith 2019-05-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151MDMetadata < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:metadataInfo][:metadataIdentifier] = {}
   mdHash[:metadata][:metadataInfo][:metadataIdentifier][:identifier] = '12345'

   @@mdHash = mdHash

   def test_mdMetadata_complete

      xFile = TestWriter191151Parent.get_xml('19115_1_mdMetadata')
      xExpect = xFile.xpath('//mdb:MD_Metadata')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', writer: 'iso19115_1', showAllTags: true
      )

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Iso19115_1::VERSION
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
      assert_equal 'iso19115_1', hResponseObj[:writerRequested]
      assert_equal writerVersion, hResponseObj[:writerVersion]
      assert hResponseObj[:writerPass]
      assert_equal 'xml', hResponseObj[:writerOutputFormat]
      assert hResponseObj[:writerShowTags]
      assert_nil hResponseObj[:writerCSSlink]
      assert_equal '_001', hResponseObj[:writerMissingIdCount]
      assert_equal translatorVersion, hResponseObj[:translatorVersion]

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//mdb:MD_Metadata')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
