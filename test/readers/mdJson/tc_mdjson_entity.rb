# MdTranslator - minitest of
# reader / mdJson / module_entity

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-07 refactored for mdJson 2.0
#   Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entity'

class TestReaderMdJsonEntity < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Entity
    aIn = TestReaderMdJsonParent.getJson('entity.json')
    @@hIn = aIn['entity'][0]

    def test_complete_entity_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'entityId', metadata[:entityId]
        assert_equal 'commonName', metadata[:entityName]
        assert_equal 'codeName', metadata[:entityCode]
        assert_equal 'alias0', metadata[:entityAlias][0]
        assert_equal 'alias1', metadata[:entityAlias][1]
        assert_equal 'primaryKeyAttributeCodeName0', metadata[:primaryKey][0]
        assert_equal 'primaryKeyAttributeCodeName1', metadata[:primaryKey][1]
        assert_empty metadata[:indexes]
        assert_empty metadata[:attributes]
        assert_empty metadata[:foreignKeys]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

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
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

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
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_entity_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end
