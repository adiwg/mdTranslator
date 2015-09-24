# MdTranslator - minitest of
# reader / mdJson / module_resolution

# History:
# Stan Smith 2015-09-22 original script

# set reader version used by mdJson_reader.rb to require correct modules
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                @responseObj = {
                    readerVersionUsed: '1.1.0'
                }

            end
        end
    end
end

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_resolution'

class TestReaderMdJsonResolution_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Resolution
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'resolution.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    # there are 2 variations to test, scale factor and distance
    @@hInSF = aIn[0]
    @@hInD  = aIn[1]

    def test_complete_resolutionScaleFactor_object
        hIn = @@hInSF.clone
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:equivalentScale], 45000
        assert_nil metadata[:distance]
        assert_nil metadata[:distanceUOM]
    end

    def test_complete_resoultionDistance_object
        hIn = @@hInD.clone
        hResponse = @@responseObj.clone
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:equivalentScale]
        assert_equal metadata[:distance], 45
        assert_equal metadata[:distanceUOM], 'kilometers'
    end

    def test_empty_resolution_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
