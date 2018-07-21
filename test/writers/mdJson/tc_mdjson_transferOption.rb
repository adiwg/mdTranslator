# mdJson 2.0 writer tests - transfer option

# History:
#  Stan Smith 2018-06-08 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-19 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonTransferOption < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTransOpt = TDClass.build_transferOption
   TDClass.add_resourceFormat(hTransOpt, 'distribution format one')
   TDClass.add_resourceFormat(hTransOpt, 'distribution format two')
   TDClass.add_onlineOption(hTransOpt,'http://adiwg.org/1',true)
   TDClass.add_onlineOption(hTransOpt,'http://adiwg.org/2',true)
   TDClass.add_offlineOption(hTransOpt,true)
   TDClass.add_offlineOption(hTransOpt,true)

   hDistributor = TDClass.build_distributor('CID003')
   hDistributor[:transferOption] << hTransOpt

   hDistribution = TDClass.build_distribution
   hDistribution[:distributor] << hDistributor

   mdHash[:metadata][:resourceDistribution] = []
   mdHash[:metadata][:resourceDistribution] << hDistribution

   @@mdHash = mdHash

   def test_schema_transferOption

      hTest = @@mdHash[:metadata][:resourceDistribution][0][:distributor][0][:transferOption][0]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'transferOption.json')
      assert_empty errors

   end

   def test_complete_transferOption

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceDistribution'][0]['distributor'][0]['transferOption']

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
