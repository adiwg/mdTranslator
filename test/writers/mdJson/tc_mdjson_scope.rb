# mdJson 2.0 writer tests - scope

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonScope < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hScope = TDClass.build_scope
   hScope[:scopeDescription] << { dataset: 'dataset one' }
   hScope[:scopeDescription] << { other: 'other one' }
   hScope[:scopeExtent] << TDClass.build_extent('scope extent one')
   hScope[:scopeExtent] << TDClass.build_extent('scope extent two')

   mdHash[:metadata][:metadataInfo][:metadataMaintenance] = TDClass.build_maintenance
   mdHash[:metadata][:metadataInfo][:metadataMaintenance][:scope] << hScope

   @@mdHash = mdHash

   def test_schema_scope

      hTest = @@mdHash[:metadata][:metadataInfo][:metadataMaintenance][:scope][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'scope.json')
      assert_empty errors

   end

   def test_complete_scope

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['metadataInfo']['metadataMaintenance']['scope']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataMaintenance']['scope']

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
