# MdTranslator - minitest of
# reader / mdJson / module_citation

# History:
# Stan Smith 2014-12-19 original script

#set globals used in testing
#set globals used by mdJson_reader.rb before requiring module
$response = {
    readerVersionUsed: '1.0',
    readerExecutionPas: true,
    readerExecutionMessages: []
}

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
$ReaderNS = ADIWG::Mdtranslator::Readers::MdJson
require 'adiwg/mdtranslator/readers/mdJson/modules_1.0/module_citation'

class TestReaderMdJsonCitation_v1_0 < MiniTest::Test

    # get json test example
    file = File.open('test/schemas/v1_0/examples/citation.json', 'r')
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
            citResourceForms: ['presentationForm1','presentationForm2'],
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

        hIn = {}

        assert_equal nil, @@NameSpace.unpack(hIn)

    end

end