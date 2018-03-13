# MdTranslator - minitest of
# reader / mdJson / module_duration

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_duration'

class TestReaderMdJsonDuration < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Duration
   aIn = TestReaderMdJsonParent.getJson('duration.json')
   @@hIn = aIn['duration'][0]

   def test_schema_duration

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'timePeriod.json', :fragment => 'duration')
      assert_empty errors

   end

   def test_complete_duration_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 1, metadata[:years]
      assert_equal 1, metadata[:months]
      assert_equal 1, metadata[:days]
      assert_equal 1, metadata[:hours]
      assert_equal 1, metadata[:minutes]
      assert_equal 1, metadata[:seconds]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_duration_elements

      # empty elements should return 0
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['years'] = nil
      hIn['months'] = nil
      hIn['days'] = nil
      hIn['hours'] = nil
      hIn['minutes'] = nil
      hIn['seconds'] = nil
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: duration not specified'

   end

   def test_missing_duration_elements

      # missing elements should return 0
      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['nonElement'] = '0'
      hIn.delete('years')
      hIn.delete('months')
      hIn.delete('days')
      hIn.delete('hours')
      hIn.delete('minutes')
      hIn.delete('seconds')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson reader: duration not specified'

   end

   def test_empty_duration_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson reader: duration object is empty'

   end

end
