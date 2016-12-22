# MdTranslator - minitest of
# reader / mdJson / module_legalConstraint

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_legalConstraint'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
                module MdJson

                    # create new internal metadata container for the reader
                    intMetadataClass = InternalMetadata.new
                    intObj = intMetadataClass.newBase

                    # first contact
                    intObj[:contacts] << intMetadataClass.newContact
                    intObj[:contacts][0][:contactId] = 'individualId0'
                    intObj[:contacts][0][:isOrganization] = false

                    @contacts = intObj[:contacts]

                end
            end
        end
    end
end

class TestReaderMdJsonLegalConstraint < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::LegalConstraint
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'legalConstraint.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['legalConstraint'][0]

    def test_complete_legalConstraint_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:constraint]
        assert_equal 2, metadata[:useCodes].length
        assert_equal 'useConstraint0', metadata[:useCodes][0]
        assert_equal 'useConstraint1', metadata[:useCodes][1]
        assert_equal 2, metadata[:accessCodes].length
        assert_equal 'accessConstraint0', metadata[:accessCodes][0]
        assert_equal 'accessConstraint1', metadata[:accessCodes][1]
        assert_equal 2, metadata[:otherCons].length
        assert_equal 'otherConstraint0', metadata[:otherCons][0]
        assert_equal 'otherConstraint1', metadata[:otherCons][1]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_legalConstraint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['useConstraint'] = []
        hIn['accessConstraint'] = []
        hIn['otherConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_legalConstraint_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('useConstraint')
        hIn.delete('accessConstraint')
        hIn.delete('otherConstraint')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_legalConstraint_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
