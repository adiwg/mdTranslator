# mdJson 2.0 writer tests - releasability

# History:
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonReleasability < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hConstraint = TDClass.build_useConstraint
   TDClass.add_releasability(hConstraint)
   mdHash[:metadata][:resourceInfo][:constraint] << hConstraint

   @@mdHash = mdHash

   def test_schema_releasability

      hTest = @@mdHash[:metadata][:resourceInfo][:constraint][1][:releasability]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'releasability.json')
      assert_empty errors

   end

   def test_complete_releasability

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['constraint']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['constraint']

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
