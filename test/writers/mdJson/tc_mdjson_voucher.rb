# mdJson 2.0 writer tests - taxonomic voucher

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-17 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonVoucher < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hVoucher = TDClass.build_taxonVoucher('specimen one', ['CID003'])
   hTaxonomy = TDClass.taxonomy
   hTaxonomy[:voucher] << hVoucher
   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   @@mdHash = mdHash

   def test_schema_voucher

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hTest = hIn[:metadata][:resourceInfo][:taxonomy][0][:voucher][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json', :fragment=>'voucher')
      assert_empty errors

   end

   def test_complete_voucher

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'none', writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceInfo']['taxonomy'][0]['voucher']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy'][0]['voucher']

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
