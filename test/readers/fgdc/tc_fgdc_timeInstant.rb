# MdTranslator - minitest of
# readers / fgdc / module_timeInstant

# History:
#   Stan Smith 2017-08-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_timeInstant'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTimeInstant < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('timeInstant.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Identification

   def test_timeInstant_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      intObj = TestReaderFGDCParent.get_intObj

      xIn = @@xDoc.xpath('./metadata/idinfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hIntObj = @@NameSpace.unpack(xIn, intObj, hResponse)

      refute_empty hIntObj
      aExtents = intObj[:metadata][:resourceInfo][:extents]

      refute_empty aExtents
      assert_equal 1, aExtents.length

      hExtent = aExtents[0]
      assert_equal 'FGDC resource time period for multiple date/times/geological age', hExtent[:description]
      assert_empty hExtent[:geographicExtents]
      assert_equal 5, hExtent[:temporalExtents].length
      assert_empty hExtent[:verticalExtents]
      
      hTempExt0 = hExtent[:temporalExtents][0]
      refute_empty hTempExt0[:timeInstant]
      assert_empty hTempExt0[:timePeriod]
      
      hTimeInst0 = hTempExt0[:timeInstant]
      assert_nil hTimeInst0[:timeId]
      assert_equal 'ground condition', hTimeInst0[:description]
      assert_empty hTimeInst0[:identifier]
      assert_empty hTimeInst0[:instantNames]
      refute_empty hTimeInst0[:timeInstant]
      assert_empty hTimeInst0[:geologicAge]

      hDateTime = hTimeInst0[:timeInstant]
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      day = hDateTime[:dateTime].day
      hour = hDateTime[:dateTime].hour
      minute = hDateTime[:dateTime].minute
      second = hDateTime[:dateTime].second
      offset = hDateTime[:dateTime].to_s.byteslice(-6,6)
      assert_equal 2015, year
      assert_equal 9, month
      assert_equal 15,day
      refute_nil 13, hour
      assert_equal 30, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

      hTempExt4 = hExtent[:temporalExtents][4]
      refute_empty hTempExt4[:timeInstant]
      assert_empty hTempExt4[:timePeriod]

      hTimeInst4 = hTempExt4[:timeInstant]
      assert_nil hTimeInst4[:timeId]
      assert_equal 'ground condition', hTimeInst4[:description]
      assert_empty hTimeInst4[:identifier]
      assert_empty hTimeInst4[:instantNames]
      assert_empty hTimeInst4[:timeInstant]
      refute_empty hTimeInst4[:geologicAge]

      hGeoAge = hTimeInst4[:geologicAge]
      assert_equal 'time scale', hGeoAge[:ageTimeScale]
      assert_equal 'geologic estimate last', hGeoAge[:ageEstimate]
      assert_equal 'geologic uncertainty', hGeoAge[:ageUncertainty]
      assert_equal 'method to estimate', hGeoAge[:ageExplanation]
      assert_empty hGeoAge[:ageReferences]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
