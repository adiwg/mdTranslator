# mdJson 2.0 writer tests - attribute value range

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-11-01 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonValueRange < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   mdHash = TDClass.base

   hAttribute = TDClass.build_entityAttribute(nil, 'ATT001', 'attribute 001 definition')
   TDClass.add_valueRange(hAttribute, 1,10)
   TDClass.add_valueRange(hAttribute, 'A','Z')
   TDClass.add_valueRange(hAttribute, -6,-50)
   TDClass.add_valueRange(hAttribute, 6.9,-50.99)

   hEntity = TDClass.build_entity('ENT001')
   hEntity[:attribute] << hAttribute

   hDictionary = TDClass.build_dataDictionary
   hDictionary[:entity] << hEntity

   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_schema_valueRange

      hTest = @@mdHash[:dataDictionary][0][:entity][0][:attribute][0][:valueRange][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'entityAttribute.json', :fragment=>'valueRange')
      assert_empty errors

   end

   def test_complete_valueRange

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['dataDictionary'][0]['entity'][0]['attribute']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['entity'][0]['attribute']

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
