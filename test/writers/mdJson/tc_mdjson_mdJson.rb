# mdJson 2.0 writer tests - mdJson

# History:
#   Stan Smith 2017-03-20 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'adiwg-mdtranslator'
require 'adiwg/mdtranslator/writers/mdJson/version'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonMdJson < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('mdJson.json')

   def test_schema_mdJson

      errors = TestWriterMdJsonParent.testSchema(@@jsonIn, 'schema.json')
      assert_empty errors

   end

   def test_complete_mdJson

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      translatorVersion = ADIWG::Mdtranslator::VERSION
      schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s

      assert_equal 'mdJson', metadata[:readerRequested]
      assert_equal '2.0.0', metadata[:readerVersionRequested]
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
      expect = JSON.parse(@@jsonIn)
      expect['schema'].delete('version')
      got = JSON.parse(metadata[:writerOutput])
      got['schema'].delete('version')

      assert_equal expect, got

   end

end
