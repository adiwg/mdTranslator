# MdTranslator - minitest of
# reader / mdJson / module_funding

# History:
#  Stan Smith 2017-08-30 refactored for mdJson schema 2.3
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_funding'

class TestReaderMdJsonFunding < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Funding
   aIn = TestReaderMdJsonParent.getJson('funding.json')
   @@hIn = aIn['funding'][0]

   def test_funding_schema

       errors = TestReaderMdJsonParent.testSchema(@@hIn, 'funding.json')
       assert_empty errors

   end

   def test_complete_funding_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'description of funding package', metadata[:description]
      assert_equal 2, metadata[:allocations].length
      refute_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_funding_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['description'] = ''
      hIn['allocation'] = []
      hIn['timePeriod'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_funding_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['nonElement'] = ''
      hIn.delete('description')
      hIn.delete('allocation')
      hIn.delete('timePeriod')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_funding_allocation

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('allocation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_empty metadata[:allocations]
      refute_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_funding_timePeriod

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('timePeriod')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:allocations]
      assert_empty metadata[:timePeriod]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_funding_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
