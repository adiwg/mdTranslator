# MdTranslator - minitest of
# parent class for all tc_fgdc tests

# History:
# Stan Smith 2017-11-17 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'nokogiri'
require 'rubygems'
require 'adiwg-mdjson_schemas'
require 'adiwg/mdtranslator'

class TestReaderFgdcParent < MiniTest::Test

   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # get file for tests from testData folder
   def self.get_file(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName) + '.json'
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return jsonFile

   end

   # get json for tests from testData folder
   def self.get_json(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName) + '.json'
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return JSON.parse(jsonFile)

   end

   # get fgdc XML for test reference from resultXML folder
   def self.get_xml(fileName)
      file = File.join(File.dirname(__FILE__), 'resultXML', fileName) + '.xml'
      xDoc = Nokogiri::XML(File.read(file))
      return xDoc
   end

   # test schema for reader modules
   def self.test_schema(mdJson, schema, fragment: nil, remove: [])

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

   def self.get_complete(fileName, path)

      # read the mdJson 2.0 file
      mdFile = TestReaderFgdcParent.get_file(fileName)

      # read the fgdc reference file
      xmlFile = TestReaderFgdcParent.get_xml(fileName)

      xExpect = xmlFile.xpath(path)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdFile, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(path)

      xExpect = xExpect.to_s.squeeze
      xGot = xGot.to_s.squeeze

      return xExpect, xGot

   end

end
