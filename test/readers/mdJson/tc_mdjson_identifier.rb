# MdTranslator - minitest of
# reader / mdJson / module_identifier

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-13 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_identifier'

class TestReaderMdJsonIdentifier < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Identifier
   aIn = TestReaderMdJsonParent.getJson('identifier.json')
   @@hIn = aIn['identifier'][0]

   def test_identifier_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'identifier.json')
      assert_empty errors

   end

   def test_complete_identifier_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'identifier', metadata[:identifier]
      assert_equal 'namespace', metadata[:namespace]
      assert_equal 'version', metadata[:version]
      assert_equal 'description', metadata[:description]
      refute_empty metadata[:citation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_identifier_identifier

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['identifier'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson identifier object identifier is missing'

   end

   def test_missing_identifier_identifier

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('identifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson identifier object identifier is missing'

   end

   def test_empty_identifier_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['namespace'] = ''
      hIn['version'] = ''
      hIn['description'] = ''
      hIn['authority'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:namespace]
      assert_nil metadata[:version]
      assert_nil metadata[:description]
      assert_empty metadata[:citation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_identifier_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('namespace')
      hIn.delete('version')
      hIn.delete('description')
      hIn.delete('authority')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:namespace]
      assert_nil metadata[:version]
      assert_nil metadata[:description]
      assert_empty metadata[:citation]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_identifier_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: identifier object is empty'

   end

end
