# mdJson 2.0 writer tests - entity

# History:
#  Stan Smith 2018-06-04 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonEntity < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # entity
   hEntity = TDClass.build_entity('EID001', 'entity 1', 'EID001', 'entity 1 definition',
                                  %w(ATT001 ATT002))

   # reference
   hEntity[:entityReference] << TDClass.build_citation('entity reference title one')
   hEntity[:entityReference] << TDClass.build_citation('entity reference title two')

   # index
   TDClass.add_dataIndex(hEntity, 'UIX001', false, ['attribute one'])
   TDClass.add_dataIndex(hEntity, 'UIX002', false, ['attribute two'])

   # attribute
   hAttribute = TDClass.build_entityAttribute(nil, 'ATT001', 'attribute 001 definition')
   hEntity[:attribute] << hAttribute

   # foreign key
   TDClass.add_foreignKey(hEntity)
   TDClass.add_foreignKey(hEntity)

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   hDictionary[:entity] << hEntity
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_schema_entity

      TDClass.removeEmptyObjects(@@mdHash)

      hTest = @@mdHash[:dataDictionary][0][:entity][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'entity.json')
      assert_empty errors

   end

   def test_complete_entity

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal', writer: 'mdJson', showAllTags: false
      )

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['dataDictionary'][0]['entity']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['entity']

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
