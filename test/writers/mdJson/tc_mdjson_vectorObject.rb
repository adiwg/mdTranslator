# mdJson 2.0 writer tests - vector object

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-15 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonVectorObject < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hSpaceRef = TDClass.build_vectorRepresentation('level one')
   TDClass.add_vectorObject(hSpaceRef,'type one', 1)
   TDClass.add_vectorObject(hSpaceRef,'type two', 2)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << { vectorRepresentation: hSpaceRef }

   @@mdHash = mdHash

   def test_schema_vectorObject

      hTest = @@mdHash[:metadata][:resourceInfo][:spatialRepresentation][0][:vectorRepresentation][:vectorObject][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'vectorRepresentation.json', :fragment=>'vectorObject')
      assert_empty errors

   end

   def test_complete_vectorObject

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['spatialRepresentation'][0]['vectorRepresentation']['vectorObject']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['spatialRepresentation'][0]['vectorRepresentation']['vectorObject']

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
