# mdJson 2.0 writer tests - bounding box

# History:
#  Stan Smith 2018-06-01 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-16 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonBoundingBox < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
   TDClass.add_altitudeBB(hGeoExtent[:boundingBox])

   @@mdHash = mdHash

   def test_schema_boundingBox

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:boundingBox]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'geographicExtent.json', :fragment=>'boundingBox')
      assert_empty errors

   end

   def test_complete_boundingBox

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['extent'][0]['geographicExtent'][0]['boundingBox']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['extent'][0]['geographicExtent'][0]['boundingBox']

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
