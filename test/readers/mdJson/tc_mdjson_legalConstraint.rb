# MdTranslator - minitest of
# reader / mdJson / module_legalConstraint

# History:
# Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_constraint'
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
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Constraint
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
    @@hIn = aIn['constraint'][0]

    def test_complete_legalConstraint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'legal', metadata[:type]
        assert_empty metadata[:useLimitation]
        assert_empty metadata[:scope]
        assert_empty metadata[:graphic]
        assert_empty metadata[:reference]
        assert_empty metadata[:releasability]
        assert_empty metadata[:responsibleParty]
        refute_empty metadata[:legalConstraint]
        assert_empty metadata[:securityConstraint]

        hLegalCon = metadata[:legalConstraint]
        assert_equal 2, hLegalCon[:useCodes].length
        assert_equal 'useConstraint0', hLegalCon[:useCodes][0]
        assert_equal 'useConstraint1', hLegalCon[:useCodes][1]
        assert_equal 2, hLegalCon[:accessCodes].length
        assert_equal 'accessConstraint0', hLegalCon[:accessCodes][0]
        assert_equal 'accessConstraint1', hLegalCon[:accessCodes][1]
        assert_equal 2, hLegalCon[:otherCons].length
        assert_equal 'otherConstraint0', hLegalCon[:otherCons][0]
        assert_equal 'otherConstraint1', hLegalCon[:otherCons][1]

        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_legalConstraint_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['legalConstraint']['useConstraint'] = []
        hIn['legalConstraint']['accessConstraint'] = []
        hIn['legalConstraint']['otherConstraint'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_legalConstraint_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['legalConstraint'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_legalConstraint

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('legalConstraint')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_constraint_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
