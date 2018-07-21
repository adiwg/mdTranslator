# MdTranslator - minitest of
# reader / mdJson / module_metadata

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadata'

class TestReaderMdJsonMetadata < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Metadata

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_metadata_full

   @@mdHash = mdHash

   def test_metadata_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'metadata.json')
      assert_empty errors

   end

   def test_complete_metadata_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:metadataInfo]
      refute_empty metadata[:resourceInfo]
      assert_equal 2, metadata[:lineageInfo].length
      assert_equal 2, metadata[:distributorInfo].length
      assert_equal 2, metadata[:associatedResources].length
      assert_equal 2, metadata[:additionalDocuments].length
      assert_equal 2, metadata[:funding].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_metadata_empty_metadataInfo

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['metadataInfo'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: metadata-info object is missing'

   end

   def test_metadata_missing_metadataInfo

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('metadataInfo')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: metadata-info object is missing'

   end

   def test_metadata_empty_resourceInfo

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['resourceInfo'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: resource-info object is missing'

   end

   def test_metadata_missing_resourceInfo

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('resourceInfo')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 
                      'ERROR: mdJson reader: resource-info object is missing'

   end

   def test_metadata_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['resourceLineage'] = []
      hIn['resourceDistribution'] = []
      hIn['associatedResource'] = []
      hIn['additionalDocumentation'] = []
      hIn['funding'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:metadataInfo]
      refute_empty metadata[:resourceInfo]
      assert_empty metadata[:lineageInfo]
      assert_empty metadata[:distributorInfo]
      assert_empty metadata[:associatedResources]
      assert_empty metadata[:additionalDocuments]
      assert_empty metadata[:funding]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_metadata_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('resourceLineage')
      hIn.delete('resourceDistribution')
      hIn.delete('associatedResource')
      hIn.delete('additionalDocumentation')
      hIn.delete('funding')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:metadataInfo]
      refute_empty metadata[:resourceInfo]
      assert_empty metadata[:lineageInfo]
      assert_empty metadata[:distributorInfo]
      assert_empty metadata[:associatedResources]
      assert_empty metadata[:additionalDocuments]
      assert_empty metadata[:funding]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_metadata_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: metadata object is empty'

   end

end
