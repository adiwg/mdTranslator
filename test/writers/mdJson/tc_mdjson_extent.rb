# mdJson 2.0 writer tests - extent

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-15 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonExtent < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hExtent = TDClass.build_extent
   TDClass.add_geographicExtent(hExtent)
   TDClass.add_geographicExtent(hExtent)
   TDClass.add_verticalExtent(hExtent)
   TDClass.add_verticalExtent(hExtent)
   TDClass.add_temporalExtent(hExtent,nil,'instant','2018-06-05T11:32')
   TDClass.add_temporalExtent(hExtent,nil,'period','2018-06-01')

   mdHash[:metadata][:resourceInfo][:extent] << hExtent

   @@mdHash = mdHash

   def test_schema_extent

      hTest = @@mdHash[:metadata][:resourceInfo][:extent][1]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'extent.json')
      assert_empty errors

   end

   def test_complete_extent

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['extent']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent']

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
