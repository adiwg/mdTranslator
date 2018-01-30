# MdTranslator - minitest of
# readers / fgdc / module_offlineOption

# History:
#   Stan Smith 2017-09-10 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcOfflineOption < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('distribution.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Distribution

   def test_offlineOption_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/distinfo[1]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDistribution = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hDistribution

      hDistributor = hDistribution[:distributor][0]
      refute_empty hDistributor

      aTransfer = hDistributor[:transferOptions]
      assert_equal 3, aTransfer.length

      hTransfer0 = aTransfer[0]
      assert_equal 4, hTransfer0[:offlineOptions].length

      hOffline0 = hTransfer0[:offlineOptions][0]
      refute_empty hOffline0[:mediumSpecification]
      assert_equal 25, hOffline0[:density]
      assert_equal 'GB', hOffline0[:units]
      assert_nil hOffline0[:numberOfVolumes]
      assert_equal 2, hOffline0[:mediumFormat].length
      assert_equal 'medium format 1', hOffline0[:mediumFormat][0]
      assert_equal 'medium format 2', hOffline0[:mediumFormat][1]
      assert_equal 'medium compatibility information', hOffline0[:note]
      assert_empty hOffline0[:identifier]

      hSpecification = hOffline0[:mediumSpecification]
      assert_equal 'medium 1', hSpecification[:title]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
