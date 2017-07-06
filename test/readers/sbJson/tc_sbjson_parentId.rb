# MdTranslator - minitest of
# reader / sbJson / module_parentId

# History:
#   Stan Smith 2017-06-21 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_parentId'

class TestReaderSbJsonParentId < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::ParentId
   @@hIn = TestReaderSbJsonParent.getJson('parentId.json')

   def test_complete_parentId

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn,hResponse)

      # test citation
      assert_equal 'U.S. Geological Survey ScienceBase parent identifier', metadata[:title]
      refute_empty metadata[:identifiers]
      assert_equal 1, metadata[:identifiers].length

      # test identifier
      hIdentifier = metadata[:identifiers][0]
      assert_equal '4f46607504a61aa9773f463d', hIdentifier[:identifier]
      assert_equal 'gov.sciencebase.catalog', hIdentifier[:namespace]
      assert_equal 'USGS ScienceBase Identifier', hIdentifier[:description]

      # test response object
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_parentId

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['parentId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn,hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_parentId

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('parentId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn,hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
