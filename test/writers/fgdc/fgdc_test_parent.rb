# MdTranslator - minitest of
# parent class for all tc_fgdc tests

# History:
# Stan Smith 2017-11-17 original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'nokogiri'
require 'rubygems'
require 'adiwg/mdtranslator'

class TestWriterFGDCParent < MiniTest::Test

   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # get file for tests from testData folder
   def self.get_json(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName) + '.json'
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return jsonFile

   end

   # get ruby hash for tests from testData folder
   def self.get_hash(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName) + '.json'
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return JSON.parse(jsonFile)

   end

   # get fgdc XML for test reference from resultXML folder
   def self.get_xml(fileName)
      file = File.join(File.dirname(__FILE__), 'testData', fileName) + '.xml'
      xDoc = Nokogiri::XML(File.read(file))
      return xDoc
   end

   def self.get_complete(hIn, expectFile, path)

      # read the fgdc reference file
      xFile = get_xml(expectFile)
      xExpect = xFile.xpath(path)
      expect = xExpect.to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )
      pass = hResponseObj[:writerPass] &&
         hResponseObj[:readerStructurePass] &&
         hResponseObj[:readerValidationPass] &&
         hResponseObj[:readerExecutionPass]

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(path)
      got = xGot.to_s.squeeze(' ')

      return expect, got, pass, hResponseObj[:writerMessages]

   end

end
