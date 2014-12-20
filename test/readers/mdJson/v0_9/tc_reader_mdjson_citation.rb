# MdTranslator - minitest of
# reader / mdJson / module_citation

# History:
# Stan Smith 2014-12-19 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '0.9',
    readerExecutionPas: true,
    readerExecutionMessages: []
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_0.9/module_citation'

class TestReaderMdJsonCitation_v0_9 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v0_9/examples/citation.json', 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)
    @@hIn = aIn[0]

    # set namespace
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Citation

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
            citResourceForms: ['presentationForm'],
            citOlResources: []
        }

        assert_equal intObj, @@NameSpace.unpack(hIn)

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

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

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

    def test_empty_citation_object

        hIn = JSON.parse('{}')
        intObj = nil

        assert_equal intObj, @@NameSpace.unpack(hIn)

    end

end