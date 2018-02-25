# MdTranslator - minitest of
# reader / mdJson / module_metadata

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadata'

class TestReaderMdJsonMetadata < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Metadata
   aIn = TestReaderMdJsonParent.getJson('metadata.json')
   @@hIn = aIn['metadata'][0]

   def test_metadata_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'metadata.json')
      assert_empty errors

   end

   def test_complete_metadata_object

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
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

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['metadataInfo'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata metadata-info object is missing'

   end

   def test_metadata_missing_metadataInfo

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('metadataInfo')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata metadata-info object is missing'

   end

   def test_metadata_empty_resourceInfo

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['resourceInfo'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata resource info object is missing'

   end

   def test_metadata_missing_resourceInfo

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('resourceInfo')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata resource info object is missing'

   end

   def test_metadata_empty_elements

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
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

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
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

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata object is empty'

   end

end
