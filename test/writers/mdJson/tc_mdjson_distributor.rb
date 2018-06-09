# mdJson 2.0 writer tests - distributor

# History:
#  Stan Smith 2018-06-04 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonDistributor < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDistributor = TDClass.build_distributor('CID003')

   TDClass.add_orderProcess(hDistributor)
   TDClass.add_orderProcess(hDistributor)

   hTransfer = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTransfer)
   hDistributor[:transferOption] << hTransfer
   hDistributor[:transferOption] << hTransfer

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor
   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_schema_distributor

      hTest = @@mdHash[:metadata][:resourceDistribution][0][:distributor][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'distributor.json')
      assert_empty errors

   end

   def test_complete_distributor

      TDClass.removeEmptyObjects(@@mdHash)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceDistribution'][0]['distributor']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution'][0]['distributor']

      assert metadata[:writerPass]
      assert metadata[:readerStructurePass]
      assert metadata[:readerValidationPass]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:writerMessages]
      assert_empty metadata[:readerStructureMessages]
      assert_empty metadata[:readerValidationMessages]
      assert_equal 2, metadata[:readerExecutionMessages].length
      assert_includes metadata[:readerExecutionMessages],
                      'WARNING: mdJson reader: transfer option did not provide an online or offline option'
      assert_equal expect, got

   end

end
