# MdTranslator - minitest of
# reader / mdJson / module_timePeriod

# History:
#  Stan Smith 2018-06-27 refactored to use mdJson construction helpers
#  Stan Smith 2017-11-07 add geologic age
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-08 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_timePeriod'

class TestReaderMdJsonTimePeriod < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TimePeriod

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_timePeriod_full

   @@mdHash = mdHash

   def test_timePeriod_schema

      # oneOf startDateTime/endDateTime
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:startDateTime)
      hIn.delete(:endDateTime)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'timeInstant.json', :remove => ['startDateTime, endDateTime'])
      assert_empty errors

      # oneOf startGeologicAge/endGeologicAge
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:startGeologicAge)
      hIn.delete(:endGeologicAge)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'timeInstant.json', :remove => ['startGeologicAge, endGeologicAge'])
      assert_empty errors

   end

   def test_complete_timePeriod_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'TPID001', metadata[:timeId]
      assert_equal 'description', metadata[:description]
      refute_empty metadata[:identifier]
      assert_equal 2, metadata[:periodNames].length
      assert_equal 'period name one', metadata[:periodNames][0]
      assert_equal 'period name two', metadata[:periodNames][1]
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

   def test_timePeriod_empty_dateAndAge_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['startDateTime'] = ''
      hIn['endDateTime'] = ''
      hIn['startGeologicAge'] = {}
      hIn['endGeologicAge'] = {}
      hIn['timeInterval'] = {}
      hIn['duration'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: time period must have a start and/or end dateTime, or geologic age: CONTEXT is testing'

   end

   def test_timePeriod_missing_dateAndAge_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('startDateTime')
      hIn.delete('endDateTime')
      hIn.delete('startGeologicAge')
      hIn.delete('endGeologicAge')
      hIn.delete('timeInterval')
      hIn.delete('duration')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: time period must have a start and/or end dateTime, or geologic age: CONTEXT is testing'

   end

   def test_empty_timePeriod_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['id'] = ''
      hIn['description'] = ''
      hIn['identifier'] = {}
      hIn['periodName'] = []
      hIn['timeInterval'] = {}
      hIn['duration'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

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

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('id')
      hIn.delete('description')
      hIn.delete('identifier')
      hIn.delete('periodName')
      hIn.delete('timeInterval')
      hIn.delete('duration')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:timeId]
      assert_nil metadata[:description]
      assert_empty metadata[:identifier]
      assert_empty metadata[:periodNames]
      assert_empty metadata[:timeInterval]
      assert_empty metadata[:duration]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timeInterval

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('startDateTime')
      hIn.delete('endDateTime')
      hIn.delete('duration')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: time interval must be accompanied by a start and/or end dateTime: CONTEXT is testing'

   end

   def test_duration

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('startDateTime')
      hIn.delete('endDateTime')
      hIn.delete('timeInterval')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: duration must be accompanied by a start and/or end dateTime: CONTEXT is testing'

   end

   def test_empty_timePeriod_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: time period object is empty: CONTEXT is testing'

   end

end
