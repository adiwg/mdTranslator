# MdTranslator - minitest of
# reader / mdJson / module_temporalExtent

# History:
#  Stan Smith 2018-06-27 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_temporalExtent'

class TestReaderMdJsonTemporalExtent < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TemporalExtent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = []
   mdHash << { timeInstant: TDClass.build_timeInstant('TI001', 'instant one', '2018-06-27-13:42')}
   mdHash << { timePeriod: TDClass.build_timePeriod('TP001', 'period one', '2018-06-27-13:42')}

   @@mdHash = mdHash

   def test_temporal_schema

      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # test timeInstant
      errors = JSON::Validator.fully_validate('temporalExtent.json', @@mdHash[0])
      assert_empty errors

      # test timePeriod
      errors = JSON::Validator.fully_validate('temporalExtent.json', @@mdHash[1])
      assert_empty errors

   end

   def test_complete_temporal_instant

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:timeInstant]
      assert_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_complete_temporal_period

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_empty metadata[:timeInstant]
      refute_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_temporal_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['timeInstant'] = {}
      hIn['timePeriod'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: temporal extent must have a time period or time instant: CONTEXT is testing'

   end

   def test_missing_temporal_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('timeInstant')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: temporal extent must have a time period or time instant: CONTEXT is testing'

   end

   def test_empty_temporal_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: temporal extent object is empty: CONTEXT is testing'

   end

end
