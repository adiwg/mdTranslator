# MdTranslator - minitest of
# reader / mdJson / module_entityAttribute

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
require 'adiwg/mdtranslator/readers/mdJson/modules_v1/module_entityAttribute'

class TestReaderMdJsonEntityAttribute_v1 < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityAttribute
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
    @@hIn = aIn[0]['entity'][0]['attribute'][0]

    def test_complete_entityAttribute_object
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal metadata[:attributeName],       'commonName11'
        assert_equal metadata[:attributeCode],       'codeName11'
        assert_equal metadata[:attributeAlias][0],   'alias111'
        assert_equal metadata[:attributeAlias][1],   'alias112'
        assert_equal metadata[:attributeDefinition], 'definition11'
        assert metadata[:allowNull]
        assert_equal metadata[:unitOfMeasure],       'units11'
        assert_equal metadata[:domainId],            'domainId11'
        assert_equal metadata[:minValue],            'minValue11'
        assert_equal metadata[:maxValue],            'maxValue11'
    end

    def test_empty_entityAttribute_codeName
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['codeName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityAttribute_definition
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['definition'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityAttribute_dataType
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['dataType'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityAttribute_allowNull
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['allowNull'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]
    end

    def test_empty_entityAttribute_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['commonName'] = ''
        hIn['alias'] = []
        hIn['units'] = ''
        hIn['domainId'] = ''
        hIn['minValue'] = ''
        hIn['maxValue'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:attributeName]
        assert_empty metadata[:attributeAlias]
        assert_nil metadata[:unitOfMeasure]
        assert_nil metadata[:domainId]
        assert_nil metadata[:minValue]
        assert_nil metadata[:maxValue]
    end

    def test_missing_entityAttribute_elements
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('commonName')
        hIn.delete('alias')
        hIn.delete('units')
        hIn.delete('domainId')
        hIn.delete('minValue')
        hIn.delete('maxValue')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata[:attributeName]
        assert_empty metadata[:attributeAlias]
        assert_nil metadata[:unitOfMeasure]
        assert_nil metadata[:domainId]
        assert_nil metadata[:minValue]
        assert_nil metadata[:maxValue]
    end

    def test_empty_entityAttribute_object
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
    end

end
