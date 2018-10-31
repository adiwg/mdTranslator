# MdTranslator - minitest of
# reader / mdJson / module_instant

# History:
#  Stan Smith 2018-06-27 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_timeInstant'

class TestReaderMdJsonTimeInstant < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::TimeInstant

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_timeInstant_full

   @@mdHash = mdHash

   def test_timeInstant_schema

      # oneOf dateTime
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:geologicAge)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'timeInstant.json', :remove => ['geologicAge'])
      assert_empty errors

      # oneOf geologicAge
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn.delete(:dateTime)
      errors = TestReaderMdJsonParent.testSchema(hIn, 'timeInstant.json', :remove => ['dateTime'])
      assert_empty errors

   end

   def test_complete_timeInstant_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'TIID001', metadata[:timeId]
      assert_equal 'description', metadata[:description]
      refute_empty metadata[:identifier]
      assert_equal 2, metadata[:instantNames].length
      assert_equal 'instant name one', metadata[:instantNames][0]
      assert_equal 'instant name two', metadata[:instantNames][1]
      refute_empty metadata[:timeInstant]
      assert_kind_of DateTime, metadata[:timeInstant][:dateTime]
      assert_equal 'YMDhms', metadata[:timeInstant][:dateResolution]
      refute_empty metadata[:geologicAge]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timeInstant_empty_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['dateTime'] = ''
      hIn['geologicAge'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: time instant must have dateTime or geologic age: CONTEXT is testing'

   end

   def test_timeInstant_missing_required

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('dateTime')
      hIn.delete('geologicAge')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: time instant must have dateTime or geologic age: CONTEXT is testing'

   end

   def test_timeInstant_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['id'] = ''
      hIn['description'] = ''
      hIn['identifier'] = {}
      hIn['instantName'] = []
      hIn['geologicAge'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:timeId]
      assert_nil metadata[:description]
      assert_empty metadata[:identifier]
      assert_empty metadata[:instantNames]
      assert_empty metadata[:geologicAge]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_timeInstant_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('id')
      hIn.delete('description')
      hIn.delete('identifier')
      hIn.delete('instantName')
      hIn.delete('geologicAge')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:timeId]
      assert_nil metadata[:description]
      assert_empty metadata[:identifier]
      assert_empty metadata[:instantNames]
      assert_empty metadata[:geologicAge]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_timeInstant_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: time instant object is empty: CONTEXT is testing'

   end

end
