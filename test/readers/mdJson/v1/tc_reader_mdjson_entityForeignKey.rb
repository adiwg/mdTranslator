# MdTranslator - minitest of
# reader / mdJson / module_entityForeignKey

# History:
# Stan Smith 2015-07-24 original script

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_entityForeignKey'

class TestReaderMdJsonForeignKey_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityForeignKey
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../../', 'schemas/v1_0/examples', 'dataDictionary.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn[0]['entity'][0]['foreignKey'][0]

    def test_complete_entityForeignKey_object
        hIn = @@hIn.clone
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_equal metadata[:fkLocalAttributes][0],      'localAttributeCodeName111'
        assert_equal metadata[:fkLocalAttributes][1],      'localAttributeCodeName112'
        assert_equal metadata[:fkReferencedEntity],        'referencedEntityCodeName11'
        assert_equal metadata[:fkReferencedAttributes][0], 'referencedAttributeCodeName111'
        assert_equal metadata[:fkReferencedAttributes][1], 'referencedAttributeCodeName112'
    end

    def test_empty_entityForeignKey_localAttributeCodeName
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['localAttributeCodeName'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityForeignKey_referencedEntityCodeName
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['referencedEntityCodeName'] = ''
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityForeignKey_referencedAttributeCodeName
        hIn = @@hIn.clone
        hResponse = @@responseObj.clone
        hIn['referencedAttributeCodeName'] = []
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityForeignKey_object
        hIn = {}
        metadata = @@NameSpace.unpack(hIn, @@responseObj)

        assert_nil metadata
    end

end
