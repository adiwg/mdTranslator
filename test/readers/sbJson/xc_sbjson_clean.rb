# MdTranslator - minitest of
# reader / sbJson / module_sbJson

# History:
#   Stan Smith 2017-08-24 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_sbJson'

class TestReaderSbJsonClean < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::SbJson
   @@hIn = TestReaderSbJsonParent.getJson('clean.json')

   def test_complete_sbJson

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
