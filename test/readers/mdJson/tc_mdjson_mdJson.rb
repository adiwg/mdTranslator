# MdTranslator - minitest of
# reader / mdJson / module_mdJson

# History:
#  Stan Smith 2018-06-20 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-07 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_mdJson'

class TestReaderMdJsonMdJson < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MdJson

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadataRepository] << TDClass.build_metadataRepository
   mdHash[:metadataRepository] << TDClass.build_metadataRepository('metadata repository two')

   mdHash[:dataDictionary] << TDClass.build_dataDictionary
   mdHash[:dataDictionary] << TDClass.build_dataDictionary
   mdHash[:dataDictionary][0].delete(:dictionaryFormat)
   mdHash[:dataDictionary][1].delete(:dictionaryFormat)

   @@mdHash = mdHash

   def test_mdJson_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'schema.json')
      assert_empty errors

   end

   def test_complete_mdJson_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:schema]
      assert_equal 4, metadata[:contacts].length
      refute_empty metadata[:metadata]
      assert_equal 2, metadata[:dataDictionaries].length
      assert_equal 2, metadata[:metadataRepositories].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_mdJson_empty_schema

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['schema'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: mdJSON schema object is missing'

   end

   def test_mdJson_missing_schema

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('schema')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: mdJSON schema object is missing'

   end

   # this test fails about 1 in 7 executions
   # the cause of failure is inconsistent
   # fails on different lines of the code, fails with different error messages
   #
   # def test_mdJson_empty_contact
   #
   #    hIn = Marshal::load(Marshal.dump(@@hIn))
   #    hIn['contact'] = []
   #    hResponse = Marshal::load(Marshal.dump(@@responseObj))
   #    metadata = @@NameSpace.unpack(hIn, hResponse)
   #
   #    assert_nil metadata
   #    refute hResponse[:readerExecutionPass]
   #    assert_equal 1, hResponse[:readerExecutionMessages].length
   #    assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: contact object is missing'
   #
   # end

   def test_mdJson_missing_contact

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('contact')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: mdJSON contact object is missing'

   end

   def test_mdJson_missing_memberOrg

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['contact'][0]['memberOfOrganization'] = []
      hIn['contact'][0]['memberOfOrganization'] << 'fakeId'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: contact membership organization not found: CONTEXT is contact CID001, membership organization ID fakeId'

   end

   def test_mdJson_empty_metadata

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['metadata'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'NOTICE: mdJson reader: mdJSON metadata object is missing'

   end

   def test_mdJson_missing_metadata

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('metadata')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'NOTICE: mdJson reader: mdJSON metadata object is missing'

   end

   def test_mdJson_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['dataDictionary'] = []
      hIn['metadataRepository'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:schema]
      assert_equal 4, metadata[:contacts].length
      refute_empty metadata[:metadata]
      assert_empty metadata[:dataDictionaries]
      assert_empty metadata[:metadataRepositories]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_mdJson_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('dataDictionary')
      hIn.delete('metadataRepository')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:schema]
      assert_equal 4, metadata[:contacts].length
      refute_empty metadata[:metadata]
      assert_empty metadata[:dataDictionaries]
      assert_empty metadata[:metadataRepositories]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_mdJson_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: mdJSON object is empty'

   end

end
