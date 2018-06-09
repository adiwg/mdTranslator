# mdJson 2.0 writer tests - phone

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-13 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonPhone < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   TDClass.add_phone(mdHash[:contact][0],'222-222-2222',%w(facsimile))
   TDClass.add_phone(mdHash[:contact][0],'333-333-3333',%w(voice fax))

   @@mdHash = mdHash

   def test_schema_phone

      hTest = @@mdHash[:contact][0][:phone][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'contact.json', fragment: 'phone')
      assert_empty errors

   end

   def test_complete_phone

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['contact'][0]['phone']
      got = JSON.parse(metadata[:writerOutput])
      got = got['contact'][0]['phone']

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
