# mdJson 2.0 writer tests - locale

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-13 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonLocale < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:metadataInfo][:defaultMetadataLocale] = TDClass.build_locale('eng','UTF-16','FJI')

   @@mdHash = mdHash

   def test_schema_locale

      hTest = @@mdHash[:metadata][:metadataInfo][:defaultMetadataLocale]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'locale.json')
      assert_empty errors

   end

   def test_complete_locale

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['metadataInfo']['defaultMetadataLocale']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['defaultMetadataLocale']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal expect, got

   end

end
