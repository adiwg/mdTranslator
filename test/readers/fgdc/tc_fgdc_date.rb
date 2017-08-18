# MdTranslator - minitest of
# readers / fgdc / module_date

# History:
#   Stan Smith 2017-09-16 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_date'

class TestReaderFgdcDate < TestReaderFGDCParent

   @@xDocLocal = TestReaderFGDCParent.get_XML('date_local.xml')
   @@xDocUTC = TestReaderFGDCParent.get_XML('date_utc.xml')

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Date

   def test_date_complete

      TestReaderFGDCParent.set_xDoc(@@xDocLocal)
      hDate = @@NameSpace.unpack('20170816', '14:08:20', 'test', @@hResponseObj)

      refute_empty hDate
      assert_kind_of DateTime, hDate[:date]
      assert_equal 'YMDhmsZ', hDate[:dateResolution]
      assert_equal 'test', hDate[:dateType]
      assert_nil hDate[:description]
      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

   def test_date_local

      TestReaderFGDCParent.set_xDoc(@@xDocLocal)
      hDate = @@NameSpace.unpack('20170816', '14:08:20', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      # cannot test hour - value dependent on timezone of travis server
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_includes([16,17],day)
      assert_equal 8, minute
      assert_equal 20, second
      assert_equal '+00:00', offset

   end

   def test_date_universal

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '14:08:20', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 14, hour
      assert_equal 8, minute
      assert_equal 20, second
      assert_equal '+00:00', offset

   end

   def test_date_Y

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('2017', '', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 1, month
      assert_equal 1,day
      assert_equal 0, hour
      assert_equal 0, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

   def test_date_YM

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('201708', '', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 1,day
      assert_equal 0, hour
      assert_equal 0, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

   def test_date_YMD

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 0, hour
      assert_equal 0, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

   def test_date_YMDh

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '14', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 14, hour
      assert_equal 0, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

   def test_date_YMDhm

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '14:08', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 14, hour
      assert_equal 8, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

   def test_date_YMDhm_no_time_separator

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '1408', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 14, hour
      assert_equal 8, minute
      assert_equal 0, second
      assert_equal '+00:00', offset

   end

   def test_date_YMDhms

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '14:08:20', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 14, hour
      assert_equal 8, minute
      assert_equal 20, second
      assert_equal '+00:00', offset

   end

   def test_date_YMDhms_no_time_separator

      TestReaderFGDCParent.set_xDoc(@@xDocUTC)
      hDate = @@NameSpace.unpack('20170816', '140820', 'test', @@hResponseObj)

      refute_empty hDate
      day = hDate[:date].day
      year = hDate[:date].year
      month = hDate[:date].month
      hour = hDate[:date].hour
      minute = hDate[:date].minute
      second = hDate[:date].second
      offset = hDate[:date].to_s.byteslice(-6,6)
      assert_equal 2017, year
      assert_equal 8, month
      assert_equal 16,day
      assert_equal 14, hour
      assert_equal 8, minute
      assert_equal 20, second
      assert_equal '+00:00', offset

   end

end
