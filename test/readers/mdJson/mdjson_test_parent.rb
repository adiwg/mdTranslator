# MdTranslator - minitest of
# parent class for all tc_mdjson tests

# History:
#  Stan Smith 2018-06-14 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-15 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_mdJson'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestReaderMdJsonParent < MiniTest::Test

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   #set up response object, contacts, and messages required for tests
   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # load contacts and messages for testing
   def self.loadEssential

      aContacts = TDClass.base[:contact]
      ADIWG::Mdtranslator::Readers::MdJson::MdJson.loadMessages
      ADIWG::Mdtranslator::Readers::MdJson::MdJson.setContacts(aContacts)

   end

   # get json file for tests from examples folder
   def self.getJson(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return JSON.parse(jsonFile)

   end

   # test schema for reader modules
   def self.testSchema(mdJson, schema, fragment: nil, remove: [])

      # load all schemas with 'true' to prohibit additional parameters
      ADIWG::MdjsonSchemas::Utils.load_schemas(false)

      # load schema segment and make all elements required and prevent additional parameters
      strictSchema = ADIWG::MdjsonSchemas::Utils.load_strict(schema)

      # remove unwanted parameters from the required array
      unless remove.empty?
         strictSchema['required'] = strictSchema['required'] - remove
      end

      # build relative path to schema fragment
      fragmentPath = nil
      if fragment
         fragmentPath = '#/definitions/' + fragment
      end

      # scan
      return JSON::Validator.fully_validate(strictSchema, mdJson, :fragment => fragmentPath)

   end

end
