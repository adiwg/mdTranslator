# MdTranslator - minitest of
# reader / mdJson / module_citation

# History:
#   Stan Smith 2016-10-13 refactored for mdJson 2.0
#   Stan Smith 2015-06-22 refactored setup to after removal of globals
#   Stan Smith 2014-12-19 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_citation'

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

class TestReaderMdJsonCitation < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Citation
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'citation.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['citation'][0]

    def test_complete_citation_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'title', metadata[:title]
        assert_equal 2, metadata[:alternateTitles].length
        assert_equal 'alternateTitle0', metadata[:alternateTitles][0]
        assert_equal 'alternateTitle1', metadata[:alternateTitles][1]
        assert_equal 2, metadata[:dates].length
        assert_equal 'edition', metadata[:edition]
        assert_equal 2, metadata[:responsibleParties].length
        assert_equal 2, metadata[:presentationForms].length
        assert_equal 'presentationForm0', metadata[:presentationForms][0]
        assert_equal 'presentationForm1', metadata[:presentationForms][1]
        assert_equal 2, metadata[:identifiers].length
        refute_empty metadata[:series]
        assert_equal 2, metadata[:otherDetails].length
        assert_equal 'otherCitationDetails0', metadata[:otherDetails][0]
        assert_equal 'otherCitationDetails1', metadata[:otherDetails][1]
        assert_equal 2, metadata[:onlineResources].length
        assert_equal 2, metadata[:browseGraphics].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_citation_title

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['title'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_citation_title

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('title')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_citation_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['alternateTitle'] = []
        hIn['date'] = []
        hIn['edition'] = ''
        hIn['responsibleParty'] = []
        hIn['presentationForm'] = []
        hIn['identifier'] = []
        hIn['series'] = {}
        hIn['otherCitationDetails'] = []
        hIn['onlineResource'] = []
        hIn['graphic'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'title', metadata[:title]
        assert_empty metadata[:alternateTitles]
        assert_empty metadata[:dates]
        assert_nil metadata[:edition]
        assert_empty metadata[:responsibleParties]
        assert_empty metadata[:presentationForms]
        assert_empty metadata[:identifiers]
        assert_empty metadata[:series]
        assert_empty metadata[:otherDetails]
        assert_empty metadata[:onlineResources]
        assert_empty metadata[:browseGraphics]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_citation_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('alternateTitle')
        hIn.delete('date')
        hIn.delete('edition')
        hIn.delete('responsibleParty')
        hIn.delete('presentationForm')
        hIn.delete('identifier')
        hIn.delete('series')
        hIn.delete('otherCitationDetails')
        hIn.delete('onlineResource')
        hIn.delete('graphic')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'title', metadata[:title]
        assert_empty metadata[:alternateTitles]
        assert_empty metadata[:dates]
        assert_nil metadata[:edition]
        assert_empty metadata[:responsibleParties]
        assert_empty metadata[:presentationForms]
        assert_empty metadata[:identifiers]
        assert_empty metadata[:series]
        assert_empty metadata[:otherDetails]
        assert_empty metadata[:onlineResources]
        assert_empty metadata[:browseGraphics]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_citation_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end