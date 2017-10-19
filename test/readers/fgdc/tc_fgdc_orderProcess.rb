# MdTranslator - minitest of
# readers / fgdc / module_orderProcess

# History:
#   Stan Smith 2017-09-10 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcOrderProcess < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('distribution.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Distribution

   def test_orderProcess_complete

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

      aOrderProcess = hDistributor[:orderProcess]
      assert_equal 3, aOrderProcess.length

      hOrder0 = aOrderProcess[0]
      assert_equal 'none', hOrder0[:fees]
      refute_empty hOrder0[:plannedAvailability]
      assert_equal 'ordering instructions', hOrder0[:orderingInstructions]
      assert_equal 'typical turnaround time', hOrder0[:turnaround]

      hPlanned0 = hOrder0[:plannedAvailability]
      assert_kind_of DateTime, hPlanned0[:dateTime]
      assert_equal 'YMDhmsZ', hPlanned0[:dateResolution]

      hOrder1 = aOrderProcess[1]
      hPlanned1 = hOrder1[:plannedAvailability]
      assert_equal hPlanned1[:dateTime], hPlanned0[:dateTime]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
