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

      TestReaderFGDCParent.set_intObj()
      TestReaderFGDCParent.set_xDoc(@@xSingle)
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      xTimePeriod = @@xSingle.xpath('./metadata/idinfo/timeperd')
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, hResponse)

      refute_empty hTimePeriod

      assert_equal 'ground condition', hTimePeriod[:description]
      assert_empty hTimePeriod[:startDateTime]
      refute_empty hTimePeriod[:endDateTime]
      assert_empty hTimePeriod[:startGeologicAge]
      assert_empty hTimePeriod[:endGeologicAge]

      hDateTime = hTimePeriod[:endDateTime]
      year = hDateTime[:dateTime].year
      month = hDateTime[:dateTime].month
      day = hDateTime[:dateTime].day
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

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timePeriod_single_geologicAge

      TestReaderFGDCParent.set_intObj()
      TestReaderFGDCParent.set_xDoc(@@xSingle)
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      xTimePeriod = @@xSingle.xpath('./metadata/idinfo/timeperd')
      xTimePeriod.xpath('//caldate').remove
      xTimePeriod.xpath('//time').remove
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, hResponse)

      refute_empty hTimePeriod

      assert_equal 'ground condition', hTimePeriod[:description]
      assert_empty hTimePeriod[:startDateTime]
      assert_empty hTimePeriod[:endDateTime]
      assert_empty hTimePeriod[:startGeologicAge]
      refute_empty hTimePeriod[:endGeologicAge]

      hGeoTime = hTimePeriod[:endGeologicAge]
      assert_equal 'time scale', hGeoTime[:ageTimeScale]
      assert_equal 'geologic estimate', hGeoTime[:ageEstimate]
      assert_equal 'geologic uncertainty', hGeoTime[:ageUncertainty]
      assert_equal 'method to estimate', hGeoTime[:ageExplanation]
      assert_equal 2, hGeoTime[:ageReferences].length

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timePeriod_multi_complete

      TestReaderFGDCParent.set_intObj()
      TestReaderFGDCParent.set_xDoc(@@xMulti)
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      xTimePeriod = @@xMulti.xpath('./metadata/idinfo/timeperd')
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, hResponse)

      refute_empty hTimePeriod
      assert_equal 'ground condition', hTimePeriod[:description]

      assert_equal 2015, hTimePeriod[:startDateTime][:dateTime].year
      assert_equal 2017, hTimePeriod[:endDateTime][:dateTime].year

      assert_equal 'geologic estimate first', hTimePeriod[:startGeologicAge][:ageEstimate]
      assert_equal 'geologic estimate last', hTimePeriod[:endGeologicAge][:ageEstimate]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timePeriod_range_complete

      TestReaderFGDCParent.set_intObj()
      TestReaderFGDCParent.set_xDoc(@@xRange)
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      xTimePeriod = @@xRange.xpath('./metadata/idinfo/timeperd')
      hTimePeriod = @@NameSpace.unpack(xTimePeriod, hResponse)

      refute_empty hTimePeriod
      assert_equal 'ground condition', hTimePeriod[:description]

      hDateTime = hTimePeriod[:startDateTime]
      year = hDateTime[:dateTime].year
      assert_equal 1990, year

      hDateTime = hTimePeriod[:endDateTime]
      year = hDateTime[:dateTime].year
      assert_equal 2016, year

      assert_equal 'geologic estimate first', hTimePeriod[:startGeologicAge][:ageEstimate]
      assert_equal 'geologic estimate last', hTimePeriod[:endGeologicAge][:ageEstimate]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
