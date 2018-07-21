# MdTranslator - minitest of
# reader / mdJson / module_orderProcess

# History:
#  Stan Smith 2018-06-22 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-21 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_orderProcess'

class TestReaderMdJsonOrderProcess < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::OrderProcess

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.orderProcess

   @@mdHash = mdHash

   def test_orderProcess_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'orderProcess.json')
      assert_empty errors

   end

   def test_complete_orderProcess_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'no charge', metadata[:fees]
      assert_kind_of DateTime, metadata[:plannedAvailability][:dateTime]
      assert_equal 'YMDhms', metadata[:plannedAvailability][:dateResolution]
      assert_equal 'ordering instructions', metadata[:orderingInstructions]
      assert_equal 'one week turnaround', metadata[:turnaround]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_orderProcess_empty_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['fees'] = ''
      hIn['plannedAvailability'] = {}
      hIn['orderingInstructions'] = ''
      hIn['turnaround'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:fees]
      assert_empty metadata[:plannedAvailability]
      assert_nil metadata[:orderingInstructions]
      assert_nil metadata[:turnaround]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_orderProcess_missing_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['nonElement'] = ''
      hIn.delete('fees')
      hIn.delete('plannedAvailability')
      hIn.delete('orderingInstructions')
      hIn.delete('turnaround')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_nil metadata[:fees]
      assert_empty metadata[:plannedAvailability]
      assert_nil metadata[:orderingInstructions]
      assert_nil metadata[:turnaround]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_orderProcess_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: order process object is empty: CONTEXT is testing'

   end

end
