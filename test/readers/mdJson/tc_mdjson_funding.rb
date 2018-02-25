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
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_funding_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('description')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:description]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_funding_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['timePeriod'] = {}
      hIn['allocation'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson funding must have either allocation or timePeriod'

   end

   def test_missing_funding_required

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('timePeriod')
      hIn.delete('allocation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson funding must have either allocation or timePeriod'

   end

   def test_empty_funding_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson funding object is empty'

   end

end
