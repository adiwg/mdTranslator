# mdJson 2.0 writer tests - taxonomy

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTaxonomy < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy = TDClass.build_taxonomy
   hTaxonomy[:taxonomicSystem] << TDClass.build_taxonSystem('taxonomic system two',
                                                            'CID003', 'modifications two')
   hTaxonomy[:identificationReference] << TDClass.build_identifier('TID001')
   hTaxonomy[:observer] << TDClass.build_responsibleParty('observer one', %w(CID003 CID004))
   hTaxonomy[:observer] << TDClass.build_responsibleParty('observer two', %w(CID003))
   hTaxonomy[:voucher] << TDClass.build_taxonVoucher('specimen one', %w(CID003))
   hTaxonomy[:voucher] << TDClass.build_taxonVoucher('specimen two', %w(CID004))

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_taxonomy

      hTest = @@mdHash[:metadata][:resourceInfo][:taxonomy][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json')
      assert_empty errors

   end

   def test_complete_taxonomy

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['taxonomy'][0]
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy'][0]

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
