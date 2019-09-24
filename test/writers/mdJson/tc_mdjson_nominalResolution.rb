# mdJson 2.0 writer tests - nominal resolution

# History:
#  Stan Smith 2019-09-24 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonNominalResolution < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.build_lineage
   hLineage[:source] << TDClass.source
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   # TODO refactor after schema update
   # def test_schema_source
   #
   #    hIn = Marshal::load(Marshal.dump(@@mdHash))
   #    hTest = hIn[:metadata][:resourceLineage][0][:source][0]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'lineage.json', :fragment=>'source')
   #    assert_empty errors
   #
   # end

   def test_complete_nominalResolution

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceLineage'][0]['source'][0]['resolution']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage'][0]['source'][0]['resolution']

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
