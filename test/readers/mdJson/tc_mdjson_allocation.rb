# MdTranslator - minitest of
# reader / mdJson / module_allocation

# History:
#  Stan Smith 2017-08-30 refactored for mdJson schema 2.3
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_allocation'

class TestReaderMdJsonAllocation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Allocation

   aIn = TestReaderMdJsonParent.getJson('allocation.json')
   @@hIn = aIn['allocation'][0]

   def test_allocation_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'funding.json', fragment: 'allocation')
      assert_empty errors

   end

   def test_complete_allocation_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'allocationId', metadata[:id]
      assert_equal 9.9, metadata[:amount]
      assert_equal 'currency', metadata[:currency]
      assert_equal 'sourceId', metadata[:sourceId]
      assert_equal 'recipientId', metadata[:recipientId]
      assert metadata[:matching]
      assert_equal 2, metadata[:onlineResources].length
      assert_equal 'comment', metadata[:comment]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_allocation_amount

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['amount'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: budget allocation amount is missing'

   end

   def test_missing_allocation_amount

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('amount')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: budget allocation amount is missing'

   end

   def test_empty_allocation_currency

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['currency'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: budget allocation currency is missing'

   end

   def test_missing_allocation_currency

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('currency')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'ERROR: mdJson reader: budget allocation currency is missing'

   end

   def test_empty_allocation_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['sourceAllocationId'] = ''
      hIn['sourceId'] = ''
      hIn['recipientId'] = ''
      hIn['matching'] = ''
      hIn['comment'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:id]
      assert_equal 9.9, metadata[:amount]
      assert_equal 'currency', metadata[:currency]
      assert_nil metadata[:source]
      assert_nil metadata[:recipient]
      refute metadata[:matching]
      assert_nil metadata[:comment]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_allocation_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('sourceAllocationId')
      hIn.delete('sourceId')
      hIn.delete('recipientId')
      hIn.delete('matching')
      hIn.delete('comment')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:id]
      assert_equal 9.9, metadata[:amount]
      assert_equal 'currency', metadata[:currency]
      assert_nil metadata[:source]
      assert_nil metadata[:recipient]
      refute metadata[:matching]
      assert_nil metadata[:comment]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_allocation_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: mdJson reader: budget allocation object is empty'

   end

end
