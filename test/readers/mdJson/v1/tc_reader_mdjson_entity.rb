# MdTranslator - minitest of
# reader / mdJson / module_entity

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_entity'

class TestReaderMdJsonEntity_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Entity
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
    @@hIn = aIn[0]['entity'][0]
    @@hIn['index'] = []
    @@hIn['attribute'] = []
    @@hIn['foreignKey'] = []

    def test_complete_entity_object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:entityId],       'entityId1'
        assert_equal metadata[:entityName],     'commonName1'
        assert_equal metadata[:entityCode],     'codeName1'
        assert_equal metadata[:entityAlias][0], 'alias11'
        assert_equal metadata[:entityAlias][1], 'alias12'
        assert_equal metadata[:primaryKey][0],  'primaryKeyAttributeCodeName11'
        assert_equal metadata[:primaryKey][1],  'primaryKeyAttributeCodeName12'
        assert_empty metadata[:indexes]
        assert_empty metadata[:attributes]
        assert_empty metadata[:foreignKeys]
    end

    def test_empty_entity_id
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['entityId'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entity_codeName
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['codeName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entity_definition
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['definition'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entity_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['commonName'] = ''
        hIn['alias'] = []
        hIn['primaryKeyAttributeCodeName'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:entityName]
        assert_empty metadata[:entityAlias]
        assert_empty metadata[:primaryKey]
    end

    def test_missing_entity_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('commonName')
        hIn.delete('alias')
        hIn.delete('primaryKeyAttributeCodeName')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:entityName]
        assert_empty metadata[:entityAlias]
        assert_empty metadata[:primaryKey]
    end

    def test_empty_entity_object
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
