# MdTranslator - minitest of
# reader / mdJson / module_metadataInfo

# History:
#  Stan Smith 2018-06-21 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-31 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadataInfo'

class TestReaderMdJsonMetadataInfo < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MetadataInfo

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_metadataInfo_full

   @@mdHash = mdHash

   def test_metadataInfo_schema

       errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'metadataInfo.json')
       assert_empty errors

   end

   def test_complete_metadataInfo_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:metadataIdentifier]
      refute_empty metadata[:parentMetadata]
      refute_empty metadata[:defaultMetadataLocale]
      assert_equal 2, metadata[:otherMetadataLocales].length
      assert_equal 2, metadata[:metadataContacts].length
      assert_equal 2, metadata[:metadataDates].length
      assert_equal 2, metadata[:metadataLinkages].length
      assert_equal 2, metadata[:metadataConstraints].length
      refute_empty metadata[:metadataMaintenance]
      assert_equal 2, metadata[:alternateMetadataReferences].length
      assert_equal 'metadata status', metadata[:metadataStatus]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_metadataInfo_contact

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['metadataContact'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: metadata contact is missing: CONTEXT is metadata-info'

   end

   def test_missing_metadataInfo_contact

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('metadataContact')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: metadata contact is missing: CONTEXT is metadata-info'

   end

   def test_empty_metadataInfo_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['metadataIdentifier'] = {}
      hIn['parentMetadata'] = {}
      hIn['defaultMetadataLocale'] = {}
      hIn['otherMetadataLocale'] = []
      hIn['metadataDate'] = []
      hIn['resourceScope'] = []
      hIn['metadataOnlineResource'] = []
      hIn['metadataConstraint'] = []
      hIn['metadataMaintenance'] = {}
      hIn['alternateMetadataReference'] = []
      hIn['metadataStatus'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:metadataIdentifier]
      assert_empty metadata[:parentMetadata]
      assert_empty metadata[:defaultMetadataLocale]
      assert_empty metadata[:otherMetadataLocales]
      assert_equal 2, metadata[:metadataContacts].length
      assert_empty metadata[:metadataDates]
      assert_empty metadata[:metadataLinkages]
      assert_empty metadata[:metadataConstraints]
      assert_empty metadata[:metadataMaintenance]
      assert_empty metadata[:alternateMetadataReferences]
      assert_nil metadata[:metadataStatus]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_metadataInfo_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('metadataIdentifier')
      hIn.delete('parentMetadata')
      hIn.delete('defaultMetadataLocale')
      hIn.delete('otherMetadataLocale')
      hIn.delete('metadataDate')
      hIn.delete('resourceScope')
      hIn.delete('metadataOnlineResource')
      hIn.delete('metadataConstraint')
      hIn.delete('metadataMaintenance')
      hIn.delete('alternateMetadataReference')
      hIn.delete('metadataStatus')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:metadataIdentifier]
      assert_empty metadata[:parentMetadata]
      assert_empty metadata[:defaultMetadataLocale]
      assert_empty metadata[:otherMetadataLocales]
      assert_equal 2, metadata[:metadataContacts].length
      assert_empty metadata[:metadataDates]
      assert_empty metadata[:metadataLinkages]
      assert_empty metadata[:metadataConstraints]
      assert_empty metadata[:metadataMaintenance]
      assert_empty metadata[:alternateMetadataReferences]
      assert_nil metadata[:metadataStatus]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_metadataInfo_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: metadata-info object is empty'

   end

end
