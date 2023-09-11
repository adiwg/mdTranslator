# MdTranslator - minitest of
# parent class for all tc_sbjson tests

# History:
# Stan Smith 2017-06- original script

require 'minitest/autorun'
require 'json'
require 'json-schema'
require 'adiwg-mdjson_schemas'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_sbJson'

class TestReaderSbJsonParent < Minitest::Test

   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # create new internal metadata container for the reader
   @@intMetadataClass = InternalMetadata.new

   # get json file for tests from examples folder
   def self.getJson(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      jsonFile = file.read
      file.close
      return JSON.parse(jsonFile)

   end

end
