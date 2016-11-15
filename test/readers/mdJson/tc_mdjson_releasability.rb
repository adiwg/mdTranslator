# MdTranslator - minitest of
# reader / mdJson / module_releasability

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_releasability'

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

class TestReaderMdJsonReleasability < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Releasability
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'releasability.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['releasability'][0]

    def test_complete_releasability_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:addressee].length
        assert_equal 'statement', metadata[:statement]
        assert_equal 2, metadata[:disseminationConstraint].length
        assert_equal 'disseminationConstraint0', metadata[:disseminationConstraint][0]
        assert_equal 'disseminationConstraint1', metadata[:disseminationConstraint][1]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_releasability_empty_addressee_statement

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['addressee'] = []
        hIn['statement'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_releasability_missing_addressee_statement

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('addressee')
        hIn.delete('statement')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_releasability_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['disseminationConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:addressee].length
        assert_equal 'statement', metadata[:statement]
        assert_empty metadata[:disseminationConstraint]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_releasability_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['disseminationConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 1, metadata[:addressee].length
        assert_equal 'statement', metadata[:statement]
        assert_empty metadata[:disseminationConstraint]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_releasability_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
