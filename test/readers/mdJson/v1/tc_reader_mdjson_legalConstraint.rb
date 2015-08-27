# MdTranslator - minitest of
# reader / mdJson / legalConstraint

# History:
# Stan Smith 2015-08-24 original script

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.2.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_legalConstraint'

class TestReaderMdJsonLegalConstraint_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::LegalConstraints
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'legalConstraints.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_legalConstraint_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:accessCodes].length, 2
        assert_equal metadata[:accessCodes][0], 'accessConstraint1'
        assert_equal metadata[:accessCodes][1], 'accessConstraint2'
        assert_equal metadata[:useCodes].length, 2
        assert_equal metadata[:useCodes][0], 'useConstraint1'
        assert_equal metadata[:useCodes][1], 'useConstraint2'
        assert_equal metadata[:otherCons].length, 2
        assert_equal metadata[:otherCons][0], 'otherConstraint1'
        assert_equal metadata[:otherCons][1], 'otherConstraint2'
    end

    def test_empty_legalConstraint_elements
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['accessConstraint'] = []
        hIn['useConstraint'] = []
        hIn['otherConstraint'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:accessCodes]
        assert_empty metadata[:useCodes]
        assert_empty metadata[:otherCons]
    end

    def test_missing_legalConstraint_elements_a
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('accessConstraint')
        hIn.delete('useConstraint')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:accessCodes]
        assert_empty metadata[:useCodes]
    end

    def test_missing_legalConstraint_elements_b
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn.delete('otherConstraint')
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_empty metadata[:otherCons]
    end

    def test_emptylegalConstraint_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
