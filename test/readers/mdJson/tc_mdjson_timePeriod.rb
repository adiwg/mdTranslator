# MdTranslator - minitest of
# reader / mdJson / module_timePeriod

# History:
#   Stan Smith 2017-11-07 add geologic age
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-08 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_timePeriod'

class TestReaderMdJsonTimePeriod < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TimePeriod
   aIn = TestReaderMdJsonParent.getJson('timePeriod.json')
   @@hIn = aIn['timePeriod'][0]

   # TODO reinstate after schema update
   # def test_timePeriod_schema
   #
   #    errors = TestReaderMdJsonParent.testSchema(@@hIn, 'timePeriod.json')
   #    assert_empty errors
   #
   # end

   def test_complete_timePeriod_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'id', metadata[:timeId]
      assert_equal 'description', metadata[:description]
      refute_empty metadata[:identifier]
      assert_equal 2, metadata[:periodNames].length
      assert_equal 'periodName0', metadata[:periodNames][0]
      assert_equal 'periodName1', metadata[:periodNames][1]
      assert_kind_of DateTime, metadata[:startDateTime][:dateTime]
      assert_equal 'YMDhmsLZ', metadata[:startDateTime][:dateResolution]
      assert_kind_of DateTime, metadata[:endDateTime][:dateTime]
      assert_equal 'YMD', metadata[:endDateTime][:dateResolution]
      refute_empty metadata[:startGeologicAge]
      refute_empty metadata[:endGeologicAge]
      refute_empty metadata[:timeInterval]
      refute_empty metadata[:duration]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timePeriod_empty_dateAgeAge_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['startDateTime'] = ''
      hIn['endDateTime'] = ''
      hIn['startGeologicAge'] = {}
      hIn['endGeologicAge'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: time period must have a starting time, ending time, or geologic age'

   end

   def test_timePeriod_missing_dateAgeAge_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('startDateTime')
      hIn.delete('endDateTime')
      hIn.delete('startGeologicAge')
      hIn.delete('endGeologicAge')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: time period must have a starting time, ending time, or geologic age'

   end

   def test_empty_timePeriod_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['id'] = ''
      hIn['description'] = ''
      hIn['identifier'] = {}
      hIn['periodName'] = []
      hIn['timeInterval'] = {}
      hIn['duration'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:timeId]
      assert_nil metadata[:description]
      assert_empty metadata[:identifier]
      assert_empty metadata[:periodNames]
      assert_empty metadata[:timeInterval]
      assert_empty metadata[:duration]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_timePeriod_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('id')
      hIn.delete('description')
      hIn.delete('identifier')
      hIn.delete('periodName')
      hIn.delete('timeInterval')
      hIn.delete('duration')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:timeId]
      assert_nil metadata[:description]
      assert_empty metadata[:identifier]
      assert_empty metadata[:periodNames]
      assert_empty metadata[:timeInterval]
      assert_empty metadata[:duration]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_timePeriod_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: time period object is empty'

   end

end
