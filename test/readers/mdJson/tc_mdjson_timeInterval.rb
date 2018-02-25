# MdTranslator - minitest of
# reader / mdJson / module_timeInterval

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-12 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_timeInterval'

class TestReaderMdJsonTimeInterval < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TimeInterval
   aIn = TestReaderMdJsonParent.getJson('timeInterval.json')
   @@hIn = aIn['timeInterval'][0]

   def test_timeInterval_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'timePeriod.json', :fragment => 'timeInterval')
      assert_empty errors

   end

   def test_complete_timeInterval_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9.9, metadata[:interval]
      assert_equal 'year', metadata[:units]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_integer_timeInterval

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['interval'] = 9
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 9, metadata[:interval]
      assert_equal 'year', metadata[:units]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_string_timeInterval

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['interval'] = '9'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson time interval must be a number'

   end

   def test_empty_timeInterval_interval

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['interval'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson time interval is missing'

   end

   def test_missing_timeInterval_interval

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('interval')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson time interval is missing'

   end

   def test_empty_timeInterval_units

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['units'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson time interval units are missing or invalid'

   end

   def test_missing_timeInterval_units

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('units')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson time interval units are missing or invalid'

   end

   def test_invalid_timeInterval_units

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['units'] = 'invalid'
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson time interval units are missing or invalid'

   end

   def test_empty_timeInterval_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson time interval object is empty'

   end

end
