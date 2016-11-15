# MdTranslator - minitest of
# reader / mdJson / module_distributor

# History:
#   Stan Smith 2016-10-21 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_distributor'

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

class TestReaderMdJsonDistributor < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Distributor
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'distributor.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['distributor'][0]

    def test_complete_distributor_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:contact]
        assert_equal 2, metadata[:orderProcess].length
        assert_equal 2, metadata[:transferOptions].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_empty_contact

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['contact'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_missing_contact

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('contact')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['orderProcess'] = []
        hIn['transferOptions'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:contact]
        assert_empty metadata[:orderProcess]
        assert_empty metadata[:transferOptions]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_distributor_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('orderProcess')
        hIn.delete('transferOptions')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:contact]
        assert_empty metadata[:orderProcess]
        assert_empty metadata[:transferOptions]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_distributor_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
