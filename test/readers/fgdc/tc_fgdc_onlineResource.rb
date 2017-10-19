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
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hOnline = @@NameSpace.unpack(linkName, linkDescription,hResponse)

      refute_empty hOnline
      assert_equal linkName, hOnline[:olResURI]
      assert_equal linkDescription, hOnline[:olResDesc]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
