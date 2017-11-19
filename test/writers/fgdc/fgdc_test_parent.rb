# MdTranslator - minitest of
# parent class for all tc_fgdc tests

# History:
# Stan Smith 2017-11-17 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'nokogiri'
require 'adiwg-mdjson_schemas'

class TestReaderFgdcParent < MiniTest::Test

   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # get file for tests from testData folder
   def self.get_file(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return jsonFile

   end

   # get json for tests from testData folder
   def self.get_json(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return JSON.parse(jsonFile)

   end

   # get fgdc XML for test reference from resultXML folder
   def self.get_xml(fileName)
      file = File.join(File.dirname(__FILE__), 'resultXML', fileName)
      xDoc = Nokogiri::XML(File.read(file))
      return xDoc
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
