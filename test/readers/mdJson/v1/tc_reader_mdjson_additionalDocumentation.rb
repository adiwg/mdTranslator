# MdTranslator - minitest of
# reader / mdJson / module_additionalDocumentation

# History:
# Stan Smith 2014-12-30 original script
# Stan Smith 2015-06-22 refactored setup to after removal of globals

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_additionalDocumentation'

class TestReaderMdJsonAdditionalDocumentation_v1 < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::AdditionalDocumentation
    @@responseObj = {
        readerVersionUsed: '1.0',
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'additionalDocumentation.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # remove responsible party from citation to prevent search for contact
    # in contact array which has not been loaded
    @@hIn = aIn[0]
    @@hIn['citation']['responsibleParty'] = []
    @@hIn['citation']['identifier']= []

    def test_complete_additionalDocumentation_object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:resourceType], 'resourceType'
        refute_empty metadata[:citation]
    end

    def test_empty_additionalDocumentation_citation
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['citation'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hResponse[:readerExecutionPass] = true
        hResponse[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_missing_additionalDocumentation_citation
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('citation')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        hResponse[:readerExecutionPass] = true
        hResponse[:readerExecutionMessages] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_additionalDocumentation_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['resourceType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:resourceType]
        refute_empty metadata[:citation]
    end

    def test_missing_additionalDocumentation_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('resourceType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:resourceType]
        refute_empty metadata[:citation]
    end

    def test_empty_additionalDocumentation_object
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end