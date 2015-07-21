# MdTranslator - code to test mdtranslator from Ruby Terminal during development

# History:
# Stan Smith 2014-07-02 original script
# Josh Bradley 2014-09-28 updated to use test/unit
# Stan Smith 2015-01-16 changed ADIWG::Mdtranslator.translate() to keyword parameters
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
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg-mdtranslator'

class TestTranslation_v1 < MiniTest::Test


    @@reader = 'mdJson'
    @@writer = 'iso19110'

    def test_19110_success

        # get json file for tests from examples folder
        file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'full_example.json')
        file = File.open(file, 'r')
        jsonObj = file.read
        file.close

        # call opening module in mdTranslator
        metadata = ADIWG::Mdtranslator.translate(
            file: jsonObj, reader: @@reader, validate: 'normal',
            writer: 'iso19110', showAllTags: 'true')

        assert_equal('json', metadata[:readerFormat], 'Check reader name')
        assert metadata[:readerStructurePass], metadata[:readerStructureMessages].join(',')
        assert_equal(@@reader, metadata[:readerRequested])
        assert metadata[:readerValidationPass], "reader validation failed: \n" + metadata[:readerValidationMessages].join(',')
        assert_equal('iso19110', metadata[:writerName])
        assert metadata[:writerPass], "writer validation failed: \n" + metadata[:writerMessages].join(',')
        refute_nil metadata[:writerOutput]
    end

end
