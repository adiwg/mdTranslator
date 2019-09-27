# mdJson 2.0 writer tests - source

# History:
#  Stan Smith 2019-09-24 add LE_Source support
#  Stan Smith 2018-06-07 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonSource < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.build_lineage
   hLineage[:source] << TDClass.build_leSource_full
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

   def test_complete_source

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceLineage'][0]['source']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceLineage'][0]['source']

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
