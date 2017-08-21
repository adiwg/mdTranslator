# MdTranslator - minitest of
# readers / fgdc / module_timeInstant

# History:
#   Stan Smith 2017-09-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_timeInstant'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTimeInstant < TestReaderFGDCParent

   @@xDateUTC = TestReaderFGDCParent.get_XML('date_utc.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::TimeInstant

   def test_timeInstant_complete

      TestReaderFGDCParent.set_xDoc(@@xDateUTC)
      hTimeInstant = @@NameSpace.unpack('20170821', '142600', @@hResponseObj)

      refute_empty hTimeInstant
      assert_nil hTimeInstant[:timeId]
      assert_nil hTimeInstant[:description]
      assert_empty hTimeInstant[:identifier]
      assert_empty hTimeInstant[:instantNames]
      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

      hDateTime = hTimeInstant[:timeInstant]
      day = hDateTime[:dateTime].day
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      hour = hDateTime[:dateTime].hour
      minute = hDateTime[:dateTime].minute
      second = hDateTime[:dateTime].second
      offset = hDateTime[:dateTime].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 21,day
      assert_equal 14, hour
      assert_equal 26, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

end
