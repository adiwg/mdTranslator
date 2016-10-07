# MdTranslator - minitest of
# reader / mdJson / module_entityForeignKey

# History:
# Stan Smith 2016-10-06 refactored for mdJson 2.0
# Stan Smith 2015-07-24 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/mdJson_reader'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entityForeignKey'

class TestReaderMdJsonForeignKey < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityForeignKey
    @@responseObj = {
        readerExecutionMessages: [],
        readerExecutionPass: true
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), '../../', 'schemas/examples', 'foreignKey.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['foreignKey'][0]

    def test_complete_entityForeignKey_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 'localAttributeCodeName0', metadata[:fkLocalAttributes][0]
        assert_equal 'localAttributeCodeName1', metadata[:fkLocalAttributes][1]
        assert_equal 'referencedEntityCodeName1', metadata[:fkReferencedEntity]
        assert_equal 'referencedAttributeCodeName0', metadata[:fkReferencedAttributes][0]
        assert_equal 'referencedAttributeCodeName1', metadata[:fkReferencedAttributes][1]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_entityForeignKey_localAttributeCodeName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['localAttributeCodeName'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_entityForeignKey_referencedEntityCodeName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['referencedEntityCodeName'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_entityForeignKey_referencedAttributeCodeName

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['referencedAttributeCodeName'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_entityForeignKey_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata

    end

end
