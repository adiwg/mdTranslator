# MdTranslator - minitest of
# reader / mdJson / module_maintenance

# History:
#   Stan Smith 2016-10-23 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_maintenance'

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

class TestReaderMdJsonMaintenance < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Maintenance
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'maintenance.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['resourceMaintenance'][0]

    def test_complete_maintenance_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'frequency', metadata[:frequency]
        assert_equal 2, metadata[:dates].length
        assert_equal 2, metadata[:scopes].length
        assert_equal 2, metadata[:notes].length
        assert_equal 2, metadata[:contacts].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_maintenance_empty_frequency

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['frequency'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_maintenance_missing_frequency

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('frequency')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_maintenance_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['date'] = []
        hIn['scope'] = []
        hIn['note'] = []
        hIn['contact'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'frequency', metadata[:frequency]
        assert_empty metadata[:dates]
        assert_empty metadata[:scopes]
        assert_empty metadata[:notes]
        assert_empty metadata[:contacts]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_maintenance_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('date')
        hIn.delete('scope')
        hIn.delete('note')
        hIn.delete('contact')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'frequency', metadata[:frequency]
        assert_empty metadata[:dates]
        assert_empty metadata[:scopes]
        assert_empty metadata[:notes]
        assert_empty metadata[:contacts]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_maintenance_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
