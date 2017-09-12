# MdTranslator - minitest of
# readers / fgdc / module_timePeriod

# History:
#   Stan Smith 2017-08-21 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_timePeriod'
require_relative 'fgdc_test_parent'

class TestReaderFgdcTimePeriod < TestReaderFGDCParent

   @@xSingle = TestReaderFGDCParent.get_XML('timePeriod_single.xml')
   @@xRange = TestReaderFGDCParent.get_XML('timePeriod_range.xml')
   @@xMulti = TestReaderFGDCParent.get_XML('timePeriod_multi.xml')

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::TimePeriod

   def test_timePeriod_single_complete

      TestReaderFGDCParent.set_xDoc(@@xSingle)
      xTimePeriod = @@xSingle.xpath('./metadata/idinfo/timeperd')
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, @@hResponseObj)

      refute_empty hTimePeriod
      assert_equal 'ground condition', hTimePeriod[:description]

      hDateTime = hTimePeriod[:endDateTime]
      day = hDateTime[:dateTime].day
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      hour = hDateTime[:dateTime].hour
      minute = hDateTime[:dateTime].minute
      second = hDateTime[:dateTime].second
      offset = hDateTime[:dateTime].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 20,day
      assert_equal 13, hour
      assert_equal 30, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

      assert_empty hTimePeriod[:startDateTime]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

   def test_timePeriod_range_complete

      TestReaderFGDCParent.set_xDoc(@@xRange)
      xTimePeriod = @@xRange.xpath('./metadata/idinfo/timeperd')
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, @@hResponseObj)

      refute_empty hTimePeriod
      assert_equal 'ground condition', hTimePeriod[:description]

      hDateTime = hTimePeriod[:startDateTime]
      day = hDateTime[:dateTime].day
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      hour = hDateTime[:dateTime].hour
      minute = hDateTime[:dateTime].minute
      second = hDateTime[:dateTime].second
      offset = hDateTime[:dateTime].to_s.byteslice(-6,6)
      assert_equal 1990, year
      assert_equal 7, month
      assert_equal 1,day
      assert_equal 12, hour
      assert_equal 30, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

      hDateTime = hTimePeriod[:endDateTime]
      day = hDateTime[:dateTime].day
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      hour = hDateTime[:dateTime].hour
      minute = hDateTime[:dateTime].minute
      second = hDateTime[:dateTime].second
      offset = hDateTime[:dateTime].to_s.byteslice(-6,6)
      assert_equal 2016, year
      assert_equal 1, month
      assert_equal 1,day
      assert_equal 17, hour
      assert_equal 30, minute
      assert_equal 00, second
      assert_equal '+00:00', offset

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

   def test_timePeriod_multi_complete

      TestReaderFGDCParent.set_xDoc(@@xMulti)
      xTimePeriod = @@xMulti.xpath('./metadata/idinfo/timeperd')
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, @@hResponseObj)

      refute_empty hTimePeriod
      assert_equal 'ground condition', hTimePeriod[:description]

      hDateTime = hTimePeriod[:startDateTime]
      day = hDateTime[:dateTime].day
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      hour = hDateTime[:dateTime].hour
      minute = hDateTime[:dateTime].minute
      second = hDateTime[:dateTime].second
      offset = hDateTime[:dateTime].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 9, month
      assert_equal 1,day
      assert_equal 13, hour
      assert_equal 30, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

      assert_empty hTimePeriod[:endDateTime]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
