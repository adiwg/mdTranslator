# MdTranslator - minitest of
# readers / fgdc / module_transferInfo

# History:
#   Stan Smith 2017-09-10 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTransferInfo < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('distribution.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Distribution

   def test_transferInfo_complete

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
      assert_nil hTransfer0[:unitsOfDistribution]
      assert_equal 999, hTransfer0[:transferSize]
      assert_equal 5, hTransfer0[:onlineOptions].length
      assert_equal 4, hTransfer0[:offlineOptions].length
      assert_empty hTransfer0[:transferFrequency]
      assert_equal 1, hTransfer0[:distributionFormats].length

      hFormat0 = hTransfer0[:distributionFormats][0]
      refute_empty hFormat0[:formatSpecification]
      assert_nil hFormat0[:amendmentNumber]
      assert_equal 'winzip legacy compression', hFormat0[:compressionMethod]
      assert_equal 'distribution technical prerequisite', hFormat0[:technicalPrerequisite]

      hSpecification = hFormat0[:formatSpecification]
      assert_equal 'format specification', hSpecification[:title]
      assert_equal 1, hSpecification[:dates].length
      assert_kind_of DateTime, hSpecification[:dates][0][:date]
      assert_equal 'YMDhmsZ', hSpecification[:dates][0][:dateResolution]
      assert_equal '1.13.2', hSpecification[:edition]
      assert_equal 1, hSpecification[:otherDetails].length
      assert_equal 'format information content', hSpecification[:otherDetails][0]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
