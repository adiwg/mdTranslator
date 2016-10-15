# MdTranslator - minitest of
# reader / mdJson / module_constraint

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'

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

class TestReaderMdJsonConstraint < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'constraint.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['constraint'][0]

    def test_complete_constraint_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:useLimitation].length
        assert_equal 'useLimitation0', metadata[:useLimitation][0]
        assert_equal 'useLimitation1', metadata[:useLimitation][1]
        refute_empty metadata[:scope]
        refute_empty metadata[:graphic]
        refute_empty metadata[:reference]
        refute_empty metadata[:releasability]
        refute_empty metadata[:responsibleParty]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_constraint_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['useLimitation'] = []
        hIn['scope'] = {}
        hIn['graphic'] = []
        hIn['reference'] = []
        hIn['releasability'] = {}
        hIn['responsibleParty'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_constraint_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['nonElement'] = ''
        hIn.delete('useLimitation')
        hIn.delete('scope')
        hIn.delete('graphic')
        hIn.delete('reference')
        hIn.delete('releasability')
        hIn.delete('responsibleParty')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end


    def test_empty_constraint_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        require 'pp'
        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
