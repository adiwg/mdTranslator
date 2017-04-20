# MdTranslator - minitest of
# reader / mdJson / module_entityAttribute

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entityAttribute'

class TestReaderMdJsonEntityAttribute < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityAttribute
    aIn = TestReaderMdJsonParent.getJson('entityAttribute.json')
    @@hIn = aIn['attribute'][0]

    def test_entityAttribute_schema

        errors = TestReaderMdJsonParent.testSchema(@@hIn, 'entity.json', :fragment=>'attribute')
        assert_empty errors

    end

    def test_complete_entityAttribute_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'commonName', metadata[:attributeName]
        assert_equal 'codeName', metadata[:attributeCode]
        assert_equal 'alias0', metadata[:attributeAlias][0]
        assert_equal 'alias1', metadata[:attributeAlias][1]
        assert_equal 'definition', metadata[:attributeDefinition]
        assert metadata[:allowNull]
        refute metadata[:allowMany]
        assert_equal 'units', metadata[:unitOfMeasure]
        assert_equal 'domainId', metadata[:domainId]
        assert_equal 'minValue', metadata[:minValue]
        assert_equal 'maxValue', metadata[:maxValue]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

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

    def test_missing_entityAttribute_codeName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('codeName')
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

    def test_missing_entityAttribute_definition

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('definition')
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

    def test_missing_entityAttribute_dataType

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('dataType')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_entityAttribute_cardinality

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['allowNull'] = ''
        hIn['allowMany'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'commonName', metadata[:attributeName]
        assert_equal 'codeName', metadata[:attributeCode]
        assert_equal 'alias0', metadata[:attributeAlias][0]
        assert_equal 'alias1', metadata[:attributeAlias][1]
        assert_equal 'definition', metadata[:attributeDefinition]
        refute metadata[:allowNull]
        refute metadata[:allowMany]
        assert_equal 'units', metadata[:unitOfMeasure]
        assert_equal 'domainId', metadata[:domainId]
        assert_equal 'minValue', metadata[:minValue]
        assert_equal 'maxValue', metadata[:maxValue]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_missing_entityAttribute_cardinality

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('allowNull')
        hIn.delete('allowMany')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'commonName', metadata[:attributeName]
        assert_equal 'codeName', metadata[:attributeCode]
        assert_equal 'alias0', metadata[:attributeAlias][0]
        assert_equal 'alias1', metadata[:attributeAlias][1]
        assert_equal 'definition', metadata[:attributeDefinition]
        refute metadata[:allowNull]
        refute metadata[:allowMany]
        assert_equal 'units', metadata[:unitOfMeasure]
        assert_equal 'domainId', metadata[:domainId]
        assert_equal 'minValue', metadata[:minValue]
        assert_equal 'maxValue', metadata[:maxValue]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

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
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
