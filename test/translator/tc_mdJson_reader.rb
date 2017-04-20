# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / mdJson_reader

# History:
#   Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'

class TestMdJsonReader < MiniTest::Test

    def test_mdJson_reader_invalid_mdJson

        # read in an mdJson 2.x test file with invalid structure
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_invalid.json')
        file = File.open(file, 'r')
        jsonInvalid = file.read
        file.close

        metadata = ADIWG::Mdtranslator.translate(file: jsonInvalid)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]
        assert metadata[:readerValidationPass]
        assert_empty metadata[:readerValidationMessages]
        assert metadata[:readerExecutionPass]
        assert_empty metadata[:readerExecutionMessages]

    end

    def test_mdJson_reader_empty_mdJson

        metadata = ADIWG::Mdtranslator.translate(file: '{}')

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_missing_schema

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # delete mdJson schema object
        hJson = JSON.parse(jsonMinimal)
        hJson.delete('schema')
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_schema_missing_name

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # delete mdJson schema name
        hJson = JSON.parse(jsonMinimal)
        hSchema = hJson['schema']
        hSchema.delete('name')
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_schema_name_empty

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # empty mdJson schema name
        hJson = JSON.parse(jsonMinimal)
        hSchema = hJson['schema']
        hSchema['name'] = ''
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_schema_name_not_mdJson

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # empty mdJson schema name
        hJson = JSON.parse(jsonMinimal)
        hSchema = hJson['schema']
        hSchema['name'] = 'badName'
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_schema_missing_version

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # delete mdJson schema name
        hJson = JSON.parse(jsonMinimal)
        hSchema = hJson['schema']
        hSchema.delete('version')
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_schema_version_old

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # empty mdJson schema name
        hJson = JSON.parse(jsonMinimal)
        hSchema = hJson['schema']
        hSchema['version'] = '1.0.3'
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

    def test_mdJson_reader_schema_version_future

        # read in an mdJson 2.x test file with schema object
        file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
        file = File.open(file, 'r')
        jsonMinimal = file.read
        file.close

        # empty mdJson schema name
        hJson = JSON.parse(jsonMinimal)
        hSchema = hJson['schema']
        hSchema['version'] = '2.100.0'
        jsonIn = hJson.to_json

        metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

        refute_empty metadata
        assert_equal 'mdJson', metadata[:readerRequested]
        refute metadata[:readerStructurePass]
        refute_empty metadata[:readerStructureMessages]

    end

end

