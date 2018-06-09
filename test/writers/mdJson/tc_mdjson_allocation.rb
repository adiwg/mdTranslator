# mdJson 2.0 writer tests - allocation

# History:
#  Stan Smith 2018-05-31 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonAllocation < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hFunding = TDClass.build_funding
   TDClass.add_allocation(hFunding, 'SAID002', 90000, 'USD', 'allocation comment two')
   mdHash[:metadata][:funding] = []
   mdHash[:metadata][:funding] << hFunding

   @@mdHash = mdHash

   def test_schema_allocation

      hTest = @@mdHash[:metadata][:funding][0][:allocation][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'funding.json', fragment: 'allocation')
      assert_empty errors

   end

   def test_complete_allocation

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['funding'][0]['allocation']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['funding'][0]['allocation']

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
