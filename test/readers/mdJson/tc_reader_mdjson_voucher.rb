# MdTranslator - minitest of
# reader / mdJson / module_voucher

# History:
#   Stan Smith 2016-10-21 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_voucher'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                # create new internal metadata container for the reader
                intMetadataClass = InternalMetadata.new
                @intObj = intMetadataClass.newBase

                # first contact
                @intObj[:contacts] << intMetadataClass.newContact
                @intObj[:contacts][0][:contactId] = 'individualId0'
                @intObj[:contacts][0][:isOrganization] = false

            end
        end
    end
end

class TestReaderMdJsonVoucher < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Voucher
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'voucher.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['voucher'][0]

    def test_complete_voucher_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'specimen', metadata[:specimen]
        refute_empty metadata[:repository]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_voucher_empty_specimen

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['specimen'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_voucher_missing_specimen

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('specimen')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_voucher_empty_repository

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['repository'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_voucher_missing_repository

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('repository')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_voucher_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
