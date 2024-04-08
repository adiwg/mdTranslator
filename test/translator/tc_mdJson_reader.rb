# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / mdJson_reader

# History:
#   Stan Smith 2016-11-14 original script

require 'minitest/autorun'
require 'json'
require 'rubygems'
require 'adiwg/mdtranslator'

class TestMdJsonReader < Minitest::Test

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

   def test_mdJson_reader_schema_version_future_minor

      # read in an mdJson 2.x test file with schema object
      file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
      file = File.open(file, 'r')
      jsonMinimal = file.read
      file.close

      # bump minor version
      version = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s
      aVersion = version.split('.')
      newMinor = aVersion[1].to_i + 1
      testVersion = aVersion[0] + '.' + newMinor.to_s + '.' + aVersion[2]

      hJson = JSON.parse(jsonMinimal)
      hSchema = hJson['schema']
      hSchema['version'] = testVersion
      jsonIn = hJson.to_json

      metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

      refute_empty metadata
      assert_equal 'mdJson', metadata[:readerRequested]
      refute metadata[:readerStructurePass]
      refute_empty metadata[:readerStructureMessages]

   end

   def test_mdJson_reader_schema_version_future_major

      # read in an mdJson 2.x test file with schema object
      file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
      file = File.open(file, 'r')
      jsonMinimal = file.read
      file.close

      # bump major version
      version = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s
      aVersion = version.split('.')
      newMajor = aVersion[0].to_i + 1
      testVersion = newMajor.to_s + '.' +  aVersion[1] + '.' + aVersion[2]

      hJson = JSON.parse(jsonMinimal)
      hSchema = hJson['schema']
      hSchema['version'] = testVersion
      jsonIn = hJson.to_json

      metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

      refute_empty metadata
      assert_equal 'mdJson', metadata[:readerRequested]
      refute metadata[:readerStructurePass]
      refute_empty metadata[:readerStructureMessages]

   end

   def test_mdJson_reader_schema_version_past_major

      # read in an mdJson 2.x test file with schema object
      file = File.join(File.dirname(__FILE__), 'testData', 'mdJson_minimal.json')
      file = File.open(file, 'r')
      jsonMinimal = file.read
      file.close

      # downgrade major version
      version = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s
      aVersion = version.split('.')
      newMajor = aVersion[0].to_i - 1
      testVersion = newMajor.to_s + '.' +  aVersion[1] + '.' + aVersion[2]

      # empty mdJson schema name
      hJson = JSON.parse(jsonMinimal)
      hSchema = hJson['schema']
      hSchema['version'] = testVersion
      jsonIn = hJson.to_json

      metadata = ADIWG::Mdtranslator.translate(file: jsonIn)

      refute_empty metadata
      assert_equal 'mdJson', metadata[:readerRequested]
      refute metadata[:readerStructurePass]
      refute_empty metadata[:readerStructureMessages]

   end

end

