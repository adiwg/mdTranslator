# MdTranslator - minitest of
# reader / sbJson / module_id

# History:
#   Stan Smith 2017-06-14 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_id'

class TestReaderSbJsonId < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Id
   @@hIn = TestReaderSbJsonParent.getJson('id.json')

   def test_complete_id

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'SB123456789', metadata[:identifier]
      assert_equal 'gov.sciencebase.catalog', metadata[:namespace]
      assert_equal 'USGS ScienceBase Identifier', metadata[:description]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_id

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['id'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_id

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('id')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
