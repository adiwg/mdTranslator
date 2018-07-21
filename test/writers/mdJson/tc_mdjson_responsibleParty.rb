# mdJson 2.0 writer tests - responsible party

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonResponsibleParty < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hResParty = TDClass.build_responsibleParty('contact', %w(CID003 CID004))
   hResParty[:roleExtent] << TDClass.build_extent
   hResParty[:roleExtent] << TDClass.build_extent
   mdHash[:metadata][:metadataInfo][:metadataContact] << hResParty

   @@mdHash = mdHash

   def test_schema_responsibleParty

      hTest = @@mdHash[:metadata][:metadataInfo][:metadataContact][1]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'responsibility.json')
      assert_empty errors

   end

   def test_complete_responsibleParty

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['metadataInfo']['metadataContact']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataContact']

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
