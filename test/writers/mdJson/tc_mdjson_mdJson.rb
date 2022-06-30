# mdJson 2.0 writer tests - mdJson

# History:
#  Stan Smith 2018-06-06 refactor to use mdJson construction helpers
#  Stan Smith 2017-03-20 original script

require 'adiwg-mdtranslator'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonMdJson < TestWriterMdJsonParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadataRepository] << TDClass.build_metadataRepository
   mdHash[:metadataRepository] << TDClass.build_metadataRepository('metadata repository two')

   mdHash[:dataDictionary] << TDClass.build_dataDictionary
   mdHash[:dataDictionary] << TDClass.build_dataDictionary
   mdHash[:dataDictionary][0].delete(:dictionaryFormat)
   mdHash[:dataDictionary][1].delete(:dictionaryFormat)

   @@mdHash = mdHash

   def test_schema_mdJson

      errors = TestWriterMdJsonParent.testSchema(@@mdHash, 'schema.json', remove: ['externalIdentifiers'])
      assert_empty errors

   end

   def test_complete_mdJson

      TDClass.removeEmptyObjects(@@mdHash)

      @@mdHash[:contact][0].delete(:externalIdentifiers)
      @@mdHash[:contact][1].delete(:externalIdentifiers)

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      translatorVersion = ADIWG::Mdtranslator::VERSION
      schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s

      assert_equal 'mdJson', metadata[:readerRequested]
      assert_equal '2.4.0', metadata[:readerVersionRequested]
      assert_equal schemaVersion, metadata[:readerVersionUsed]
      assert metadata[:readerStructurePass]
      assert_empty metadata[:readerStructureMessages]
      assert_equal 'normal', metadata[:readerValidationLevel]
      assert metadata[:readerValidationPass]
      assert_empty metadata[:readerValidationMessages]
      assert metadata[:readerExecutionPass]
      assert_empty metadata[:readerExecutionMessages]
      assert_equal 'mdJson', metadata[:writerRequested]
      assert_equal schemaVersion, metadata[:writerVersion]
      assert metadata[:writerPass]
      assert_equal 'json', metadata[:writerOutputFormat]
      refute metadata[:writerShowTags]
      assert_nil metadata[:writerCSSlink]
      assert_equal '_000', metadata[:writerMissingIdCount]
      assert_equal translatorVersion, metadata[:translatorVersion]

      # delete version
      # mdJson is always written to latest schema version
      # mdJson input may be older
      expect = JSON.parse(@@mdHash.to_json)
      expect['schema'].delete('version')
      got = JSON.parse(metadata[:writerOutput])
      got['schema'].delete('version')

      # expect['contact'][0].delete('externalIdentifiers')
      # expect['contact'][1].delete('externalIdentifiers')

      # got['contact'][0].delete('externalIdentifiers')
      # got['contact'][1].delete('externalIdentifiers')

      File.write(
         'expected',
         JSON.pretty_generate(expect)
      )

      File.write(
         'actual',
         JSON.pretty_generate(got)
      )

      assert_equal expect, got

   end

end
