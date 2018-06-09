# mdJson 2.0 writer tests - dictionary

# History:
#  Stan Smith 2018-06-01 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDictionary < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDictionary = TDClass.build_dataDictionary
   hDictionary[:locale] << TDClass.locale
   hDictionary[:locale] << TDClass.locale
   hDictionary[:domain] << TDClass.build_dictionaryDomain('DOM001')
   hDictionary[:domain] << TDClass.build_dictionaryDomain('DOM002')
   hDictionary[:entity] << TDClass.build_entity('ENT001')
   hDictionary[:entity] << TDClass.build_entity('ENT002')
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   TDClass.removeEmptyObjects(@@mdHash)

   def test_schema_dictionary

      hTest = @@mdHash[:dataDictionary][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'dataDictionary.json')
      assert_empty errors

   end

   def test_complete_dictionary

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['dataDictionary']

      # delete deprecated element from source mdJson so it will match output from writer
      expect[0].delete('dictionaryFormat')

      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary']

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
