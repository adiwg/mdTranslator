# MdTranslator - minitest of
# reader / mdJson / module_additionalDocumentation

# History:
#   Stan Smith 2017-01-15 added parent class to run successfully within rake
#   Stan Smith 2016-10-17 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup to after removal of globals
#   Stan Smith 2014-12-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_additionalDocumentation'

class TestReaderMdJsonAdditionalDocumentation < TestReaderMdJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AdditionalDocumentation
   aIn = TestReaderMdJsonParent.getJson('additionalDocumentation.json')
   @@hIn = aIn['additionalDocumentation'][0]

   def test_additionalDocumentation_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'additionalDocumentation.json')
      assert_empty errors

   end

   def test_complete_additionalDocumentation_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:resourceTypes].length
      assert_equal 2, metadata[:citation].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_additionalDocumentation_resourceType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['resourceType'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson additional documentation is missing resource type'
   end

   def test_missing_additionalDocumentation_resourceType

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('resourceType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson additional documentation is missing resource type'

   end

   def test_empty_additionalDocumentation_citation

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['citation'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson additional documentation is missing citation'
   end

   def test_missing_additionalDocumentation_citation

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('citation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson additional documentation is missing citation'

   end

   def test_empty_additionalDocumentation_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: additional documentation object is empty'

   end

end
