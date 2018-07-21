# MdTranslator - minitest of
# reader / mdJson / module_duration

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-03 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_duration'

class TestReaderMdJsonDuration < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Duration

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.duration

   @@mdHash = mdHash

   def test_schema_duration

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'timePeriod.json', :fragment => 'duration')
      assert_empty errors

   end

   def test_complete_duration_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 1, metadata[:years]
      assert_equal 2, metadata[:months]
      assert_equal 3, metadata[:days]
      assert_equal 4, metadata[:hours]
      assert_equal 5, metadata[:minutes]
      assert_equal 6, metadata[:seconds]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_duration_elements

      # empty elements should return 0
      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['years'] = nil
      hIn['months'] = nil
      hIn['days'] = nil
      hIn['hours'] = nil
      hIn['minutes'] = nil
      hIn['seconds'] = nil
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: duration was not specified: CONTEXT is testing'

   end

   def test_missing_duration_elements

      # missing elements should return 0
      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = '0'
      hIn.delete('years')
      hIn.delete('months')
      hIn.delete('days')
      hIn.delete('hours')
      hIn.delete('minutes')
      hIn.delete('seconds')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: duration was not specified: CONTEXT is testing'

   end

   def test_empty_duration_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: duration object is empty: CONTEXT is testing'

   end

end
