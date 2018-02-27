# MdTranslator - minitest of
# reader / mdJson / module_metadataRepository

# History:
#   Stan Smith 2017-02-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_metadataRepository'

class TestReaderMetadataRepository < TestReaderMdJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::MetadataRepository
   aIn = TestReaderMdJsonParent.getJson('metadataRepository.json')
   @@hIn = aIn['metadataRepository'][0]

   def test_repository_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'metadataRepository.json')
      assert_empty errors

   end

   def test_complete_repository_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'repository', metadata[:repository]
      refute_empty metadata[:citation]
      assert_equal 'iso19115_2', metadata[:metadataStandard]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_repository_repository

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['repository'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata repository name is missing'

   end

   def test_missing_repository_repository

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('repository')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson metadata repository name is missing'

   end

   def test_empty_repository_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['metadataStandard'] = ''
      hIn['citation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'repository', metadata[:repository]
      assert_empty metadata[:citation]
      assert_nil metadata[:metadataStandard]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_repository_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('metadataStandard')
      hIn.delete('citation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'repository', metadata[:repository]
      assert_empty metadata[:citation]
      assert_nil metadata[:metadataStandard]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_repository_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: metadata repository object is empty'

   end

end