# MdTranslator - minitest of
# adiwg / mdtranslator / mdReaders / mdJson

# History:
#   Stan Smith 2018-07-31 original script

require 'minitest/autorun'
require 'rubygems'
require 'adiwg/mdtranslator'

class TestMdjsonSchemaExample < MiniTest::Test
   
   def test_mdJson_schema_example
      
      # read in schema example from gem
      path = Gem::Specification.find_by_name('adiwg-mdjson_schemas').full_gem_path()
      file = File.join(path, 'examples','mdJson.json')
      file = File.open(file, 'r')
      example = file.read
      file.close
      
      metadata = ADIWG::Mdtranslator.translate(file: example, reader: 'mdJson', validate: 'none')
      
      refute_empty metadata
      assert metadata[:readerStructurePass]
      assert_empty metadata[:readerStructureMessages]
      assert metadata[:readerValidationPass]
      assert_empty metadata[:readerValidationMessages]

   end

end

