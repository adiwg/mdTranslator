# mdJson 2.0 writer tests - metadata info

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-13 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonMetadataInfo < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hMetaInfo = mdHash[:metadata][:metadataInfo]

   # metadata identifier {}
   hMetaInfo[:metadataIdentifier] = TDClass.build_identifier('metadata identifier')

   # parent metadata {}
   hMetaInfo[:parentMetadata] = TDClass.build_citation('parent metadata title')

   # default metadata locale {}
   hMetaInfo[:defaultMetadataLocale] = TDClass.build_locale

   # other metadata locale []
   hMetaInfo[:otherMetadataLocale] = []
   hMetaInfo[:otherMetadataLocale] << TDClass.build_locale
   hMetaInfo[:otherMetadataLocale] << TDClass.build_locale

   # metadata online resource []
   hMetaInfo[:metadataOnlineResource] = []
   hMetaInfo[:metadataOnlineResource] << TDClass.build_onlineResource('https:/adiwg.org/1')
   hMetaInfo[:metadataOnlineResource] << TDClass.build_onlineResource('https:/adiwg.org/2')

   # metadata constraint []
   hMetaInfo[:metadataConstraint] = []
   hMetaInfo[:metadataConstraint] << TDClass.build_legalConstraint
   hMetaInfo[:metadataConstraint] << TDClass.build_legalConstraint

   # alternate metadata reference []
   hMetaInfo[:alternateMetadataReference] = []
   hMetaInfo[:alternateMetadataReference] << TDClass.build_citation('alternate reference one')
   hMetaInfo[:alternateMetadataReference] << TDClass.build_citation('alternate reference two')

   # metadata status
   hMetaInfo[:metadataStatus] = 'status'

   # metadata maintenance {}
   hMetaInfo[:metadataMaintenance] = TDClass.build_maintenance

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_schema_metadataInfo

      hTest = @@mdHash[:metadata][:metadataInfo]
      errors = TestWriterMdJsonParent.testSchema(hTest, 'metadataInfo.json')
      assert_empty errors

   end

   def test_complete_metadataInfo

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@mdHash.to_json)
      expect = expect['metadata']['metadataInfo']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']

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
