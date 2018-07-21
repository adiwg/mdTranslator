# mdJson 2.0 writer tests - domain

# History:
#  Stan Smith 2018-06-04 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDomain < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   hDomain = TDClass.build_dictionaryDomain
   TDClass.add_domainItem(hDomain)
   TDClass.add_domainItem(hDomain)
   hDictionary[:domain] << hDomain
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_schema_domain

      hTest = @@mdHash[:dataDictionary][0][:domain][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'domain.json')
      assert_empty errors

   end

   def test_complete_domain

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['dataDictionary'][0]['domain']
      got = JSON.parse(metadata[:writerOutput])
      got = got['dataDictionary'][0]['domain']

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
