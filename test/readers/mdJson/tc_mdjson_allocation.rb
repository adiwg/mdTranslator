# MdTranslator - minitest of
# reader / mdJson / module_allocation

# History:
#  Stan Smith 2018-06-15 refactored to use mdJson construction helpers
#  Stan Smith 2017-08-30 refactored for mdJson schema 2.3
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-30 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_allocation'

class TestReaderMdJsonAllocation < TestReaderMdJsonParent

   # set variables for test
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Allocation

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.allocation
   mdHash[:responsibleParty] << TDClass.build_responsibleParty('funder', ['CID004'])
   mdHash[:onlineResource] << TDClass.build_onlineResource('http://online.adiwg.org/2')

   @@mdHash = mdHash

   def test_allocation_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'funding.json', fragment: 'allocation')
      assert_empty errors

   end

   def test_complete_allocation_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'SAID001', metadata[:id]
      assert_equal 50000, metadata[:amount]
      assert_equal 'USD', metadata[:currency]
      assert_equal 'CID004', metadata[:sourceId]
      assert_equal 'CID003', metadata[:recipientId]
      assert_equal 2, metadata[:responsibleParties].length
      assert metadata[:matching]
      assert_equal 2, metadata[:onlineResources].length
      assert_equal 'allocation comment', metadata[:comment]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_allocation_amount

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['amount'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: budget allocation amount is missing'

   end

   def test_missing_allocation_amount

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('amount')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: budget allocation amount is missing'

   end

   def test_empty_allocation_currency

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['currency'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: budget allocation currency type is missing'

   end

   def test_missing_allocation_currency

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('currency')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: budget allocation currency type is missing'

   end

   def test_empty_allocation_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['sourceAllocationId'] = ''
      hIn['sourceId'] = ''
      hIn['recipientId'] = ''
      hIn['responsibleParty'] = []
      hIn['matching'] = ''
      hIn['comment'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:id]
      assert_equal 50000, metadata[:amount]
      assert_equal 'USD', metadata[:currency]
      assert_nil metadata[:source]
      assert_nil metadata[:recipient]
      assert_empty metadata[:responsibleParties]
      refute metadata[:matching]
      assert_nil metadata[:comment]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_allocation_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('sourceAllocationId')
      hIn.delete('sourceId')
      hIn.delete('recipientId')
      hIn.delete('responsibleParty')
      hIn.delete('matching')
      hIn.delete('comment')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:id]
      assert_equal 50000, metadata[:amount]
      assert_equal 'USD', metadata[:currency]
      assert_nil metadata[:source]
      assert_nil metadata[:recipient]
      assert_empty metadata[:responsibleParties]
      refute metadata[:matching]
      assert_nil metadata[:comment]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_allocation_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: budget allocation object is empty'

   end

end
