# MdTranslator - minitest of
# reader / mdJson / module_allocation

# History:
#   Stan Smith 2016-10-30 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_allocation'

class TestReaderMdJsonAllocation < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Allocation
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'allocation.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['allocation'][0]

    def test_complete_allocation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 9.9, metadata[:amount]
        assert_equal 'currency', metadata[:currency]
        assert_equal 'source', metadata[:sourceId]
        assert_equal 'recipient', metadata[:recipientId]
        assert metadata[:matching]
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
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_allocation_amount

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('amount')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_allocation_currency

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['currency'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_allocation_currency

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('currency')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_allocation_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['source'] = ''
        hIn['recipient'] = ''
        hIn['matching'] = ''
        hIn['comment'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

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
        hIn.delete('source')
        hIn.delete('recipient')
        hIn.delete('matching')
        hIn.delete('comment')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

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
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
