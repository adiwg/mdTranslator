# MdTranslator - minitest of
# reader / mdJson / module_mdJson

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-11-07 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_mdJson'

class TestReaderMdJsonMdJson < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MdJson
   @@hIn = TestReaderMdJsonParent.getJson('mdJson.json')

   def test_mdJson_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'schema.json')
      assert_empty errors

   end

   def test_complete_mdJson_object

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:schema]
      assert_equal 6, metadata[:contacts].length
      refute_empty metadata[:metadata]
      assert_equal 2, metadata[:dataDictionaries].length
      assert_equal 2, metadata[:metadataRepositories].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_mdJson_empty_schema

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['schema'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: schema object is missing'

   end

   def test_mdJson_missing_schema

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('schema')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: schema object is missing'

   end

   def test_mdJson_empty_contact

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contact'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: contact object is missing'

   end

   def test_mdJson_missing_contact

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('contact')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: contact object is missing'

   end

   def test_mdJson_missing_memberOrg

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['contact'][0]['memberOfOrganization'] << 'fakeId'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: contact CID001 organization contact ID fakeId not found'

   end

   def test_mdJson_empty_metadata

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['metadata'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: metadata object is missing'

   end

   def test_mdJson_missing_metadata

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('metadata')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: metadata object is missing'

   end

   def test_mdJson_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['dataDictionary'] = []
      hIn['metadataRepository'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:schema]
      assert_equal 6, metadata[:contacts].length
      refute_empty metadata[:metadata]
      assert_empty metadata[:dataDictionaries]
      assert_empty metadata[:metadataRepositories]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_mdJson_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('dataDictionary')
      hIn.delete('metadataRepository')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:schema]
      assert_equal 6, metadata[:contacts].length
      refute_empty metadata[:metadata]
      assert_empty metadata[:dataDictionaries]
      assert_empty metadata[:metadataRepositories]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_mdJson_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: object is empty'

   end

end
