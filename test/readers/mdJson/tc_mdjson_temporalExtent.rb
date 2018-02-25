# MdTranslator - minitest of
# reader / mdJson / module_temporalExtent

# History:
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_temporalExtent'

class TestReaderMdJsonTemporalExtent < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TemporalExtent
   aIn = TestReaderMdJsonParent.getJson('temporalExtent.json')
   @@hIn = aIn['temporalExtent']

   def test_temporal_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test timeInstant
      errors = JSON::Validator.fully_validate('temporalExtent.json', @@hIn[0])
      assert_empty errors

      # test timePeriod
      errors = JSON::Validator.fully_validate('temporalExtent.json', @@hIn[1])
      assert_empty errors

   end

   def test_complete_temporal_instant

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:timeInstant]
      assert_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_temporal_period

      hIn = Marshal::load(Marshal.dump(@@hIn[1]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:timeInstant]
      refute_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_temporal_required

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hIn['timeInstant'] = {}
      hIn['timePeriod'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson temporal extent must have a time period or time instant'

   end

   def test_missing_temporal_required

      hIn = Marshal::load(Marshal.dump(@@hIn[0]))
      hIn['nonElement'] = ''
      hIn.delete('timeInstant')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson temporal extent must have a time period or time instant'

   end

   def test_empty_temporal_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson temporal extent object is empty'

   end

end
