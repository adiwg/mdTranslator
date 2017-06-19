# MdTranslator - minitest of
# reader / sbJson / module_identifier

# History:
#   Stan Smith 2017-06-19 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_identifier'

class TestReaderSbJsonIdentifier < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Identifier
   @@hIn = TestReaderSbJsonParent.getJson('identifier.json')

   def test_identifier_array

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 2, metadata[:identifiers].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_identifier

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['identifiers'].delete_at(1)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 'identifier 1 type', metadata[:identifiers][0][:description]
      assert_equal 'namespace 1', metadata[:identifiers][0][:namespace]
      assert_equal 'identifier 1', metadata[:identifiers][0][:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_identifier_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['identifiers'].delete_at(1)
      hIn['identifiers'][0]['type'] = ''
      hIn['identifiers'][0]['scheme'] = ''
      hIn['identifiers'][0]['key'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_nil metadata[:identifiers][0][:description]
      assert_nil metadata[:identifiers][0][:namespace]
      assert_nil metadata[:identifiers][0][:identifier]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_identifiers

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['identifiers'].delete_at(1)
      hIn['identifiers'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      metadata = @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty metadata[:identifiers]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
