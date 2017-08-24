# MdTranslator - minitest of
# readers / fgdc / module_onlineResource

# History:
#   Stan Smith 2017-08-18 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_onlineResource'

class TestReaderFgdcOnlineResource < TestReaderFGDCParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::OnlineResource

   def test_onlineResource_complete

      linkName = 'https://link.name'
      linkDescription = 'link description'
      hOnline = @@NameSpace.unpack(linkName, linkDescription,@@hResponseObj)

      refute_empty hOnline
      assert_equal linkName, hOnline[:olResURI]
      assert_equal linkDescription, hOnline[:olResDesc]
      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
