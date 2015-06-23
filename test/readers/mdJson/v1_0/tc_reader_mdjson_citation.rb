# MdTranslator - minitest of
# reader / mdJson / module_citation

# History:
# Stan Smith 2014-12-19 original script
# Stan Smith 2015-06-22 refactored setup to after removal of globals

# set globals used by mdJson_reader.rb before requiring modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                $ReaderNS = ADIWG::Mdtranslator::Readers::MdJson

                @responseObj = {
                    readerVersionUsed: '1.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_citation'

class TestReaderMdJsonCitation_v1_0 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Citation
    @@responseObj = {}

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'citation.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]

    def test_complete_citation_object

        hIn = @@hIn.clone
        hIn.delete('date')
        hIn.delete('responsibleParty')
        hIn.delete('identifier')
        hIn.delete('onlineResource')

        intObj = {
            citTitle: 'title',
            citDate: [],
            citEdition: 'edition',
            citResourceIds: [],
            citResponsibleParty: [],
            citResourceForms: ['presentationForm1','presentationForm2'],
            citOlResources: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_citation_elements

        hIn = @@hIn.clone
        hIn['title'] = ''
        hIn['date'] = []
        hIn['edition'] = ''
        hIn['responsibleParty'] = []
        hIn['presentationForm'] = []
        hIn['identifier'] = []
        hIn['onlineResource'] = []

        intObj = {
            citTitle: nil,
            citDate: [],
            citEdition: nil,
            citResourceIds: [],
            citResponsibleParty: [],
            citResourceForms: [],
            citOlResources: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_missing_citation_elements

        # note: except for title

        hIn = @@hIn.clone
        hIn.delete('date')
        hIn.delete('edition')
        hIn.delete('responsibleParty')
        hIn.delete('presentationForm')
        hIn.delete('identifier')
        hIn.delete('onlineResource')

        intObj = {
            citTitle: 'title',
            citDate: [],
            citEdition: nil,
            citResourceIds: [],
            citResponsibleParty: [],
            citResourceForms: [],
            citOlResources: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn, @@responseObj)

    end

    def test_empty_citation_object

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn, @@responseObj)

    end

end