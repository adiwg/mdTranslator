# mdJson 2.0 writer tests - entity attribute

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonEntityAttribute < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # entity
   hEntity = TDClass.build_entity('EID001', 'entity 1', 'EID001', 'entity 1 definition',
                                  %w(ATT001 ATT002))

   # attribute
   hAttribute = TDClass.build_entityAttribute(nil, 'ATT001', 'attribute 001 definition')
   hAttribute[:attributeReference] = TDClass.build_citation('attribute reference title')
   TDClass.add_valueRange(hAttribute, 1,10)
   TDClass.add_valueRange(hAttribute, 'A','Z')
   hAttribute[:timePeriod] << TDClass.build_timePeriod(nil,nil,'2018-06-05')
   hAttribute[:timePeriod] << TDClass.build_timePeriod(nil,nil,'2018-06-05')

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   hEntity[:attribute] << hAttribute
   hDictionary[:entity] << hEntity
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_schema_entityAttribute
   #
   #    hTest = @@mdHash[:dataDictionary][0][:entity][0][:attribute][0]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'entityAttribute.json')
   #    assert_empty errors
   #
   # end

   def test_complete_entityAttribute

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
