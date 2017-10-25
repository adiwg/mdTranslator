# MdTranslator - minitest of
# readers / fgdc / module_identification

# History:
#   Stan Smith 2017-08-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTemporalExtent < TestReaderFGDCParent

   @@xTempEx = TestReaderFGDCParent.get_XML('temporalExtent.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Fgdc

   def test_temporalExtent_complete

      TestReaderFGDCParent.set_xDoc(@@xTempEx)
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hMetadata = @@NameSpace.unpack(@@xTempEx, hResponse)

      refute_empty hMetadata

      hResourceInfo = hMetadata[:metadata][:resourceInfo]
      refute_empty hResourceInfo
      assert_equal 1, hResourceInfo[:extents].length

      hExtent = hResourceInfo[:extents][0]
      refute_empty hExtent
      refute_nil hExtent[:description]
      assert_empty hExtent[:geographicExtents]
      assert_equal 2, hExtent[:temporalExtents].length
      assert_empty hExtent[:verticalExtents]

      hTempExtent = hExtent[:temporalExtents][0]
      refute_empty hTempExtent[:timeInstant]
      assert_empty hTempExtent[:timePeriod]

      hInstant = hTempExtent[:timeInstant]
      assert_nil hInstant[:timeId]
      refute_empty hInstant[:description]
      assert_empty hInstant[:identifier]
      assert_empty hInstant[:instantNames]
      assert_kind_of DateTime, hInstant[:timeInstant][:dateTime]
      assert_equal 'YMDhmsZ', hInstant[:timeInstant][:dateResolution]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
