# mdJson 2.0 writer tests - maintenance

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-18 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonMaintenance < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hMaintenance = TDClass.build_maintenance

   hMaintenance[:date] << TDClass.build_date('2018-05-25','lastUpdate')
   hMaintenance[:date] << TDClass.build_date('2019-04','nextUpdate')

   hMaintenance[:scope] << TDClass.scope
   hMaintenance[:scope] << TDClass.scope

   hMaintenance[:contact] << TDClass.build_responsibleParty('custodian',['CID003'])
   hMaintenance[:contact] << TDClass.build_responsibleParty('rightHolder',['CID004'])

   mdHash[:metadata][:metadataInfo][:metadataMaintenance] = hMaintenance

   @@mdHash = mdHash

   def test_schema_maintenance

      hTest = @@mdHash[:metadata][:metadataInfo][:metadataMaintenance]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'maintInfo.json')
      assert_empty errors

   end

   def test_complete_maintenance

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['metadataInfo']['metadataMaintenance']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataMaintenance']

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
