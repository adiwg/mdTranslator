# MdTranslator - minitest of
# readers / fgdc / module_onlineOption

# History:
#   Stan Smith 2017-09-10 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcOnlineOption < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('distribution.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Distribution

   def test_onlineOption_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/distinfo[1]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDistribution = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hDistribution

      hDistributor = hDistribution[:distributor][0]
      refute_empty hDistributor

      aTransfer = hDistributor[:transferOptions]
      assert_equal 3, aTransfer.length

      hTransfer0 = aTransfer[0]
      assert_equal 5, hTransfer0[:onlineOptions].length

      hOnline0 = hTransfer0[:onlineOptions][0]
      assert_equal 'https://doi.org/10.5066/1', hOnline0[:olResURI]
      assert_equal 'online access instructions', hOnline0[:olResProtocol]
      assert_nil hOnline0[:olResName]
      assert_equal 'online computer and OS', hOnline0[:olResDesc]
      assert_nil hOnline0[:olResFunction]

      assert_equal 'https://doi.org/10.5066/3', hTransfer0[:onlineOptions][2][:olResURI]
      assert_equal 'https://doi.org/10.5066/4', hTransfer0[:onlineOptions][3][:olResURI]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
