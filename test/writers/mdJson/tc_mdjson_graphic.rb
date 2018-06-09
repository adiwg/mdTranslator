# mdJson 2.0 writer tests - graphic overview

# History:
#  Stan Smith 2018-06-05 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonGraphicOverview < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGraph = TDClass.build_graphic('browse graphic one')
   hGraph[:fileUri] << TDClass.build_onlineResource('https://adiwg.org/1')
   hGraph[:fileUri] << TDClass.build_onlineResource('https://adiwg.org/2')
   hGraph[:fileConstraint] << TDClass.build_useConstraint
   hGraph[:fileConstraint] << TDClass.build_useConstraint

   mdHash[:metadata][:resourceInfo][:graphicOverview] = []
   mdHash[:metadata][:resourceInfo][:graphicOverview] << hGraph

   @@mdHash = mdHash

   def test_schema_graphic

      hTest = @@mdHash[:metadata][:resourceInfo][:graphicOverview][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'graphic.json')
      assert_empty errors

   end

   def test_complete_graphic

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['graphicOverview']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['graphicOverview']

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
