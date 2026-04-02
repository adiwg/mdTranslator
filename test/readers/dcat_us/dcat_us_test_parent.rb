# MdTranslator - minitest of
# parent class for all tc_dcat_us tests

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_dcat_us'

class TestReaderDcatUsParent < Minitest::Test

   @@responseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # create new internal metadata container for the reader
   @@intMetadataClass = InternalMetadata.new

   # Load a JSON test fixture from the testData directory.
   def self.getJson(fileName)
      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      file = File.open(file, 'r')
      json_str = file.read
      file.close
      JSON.parse(json_str)
   end

   # Load the first dataset from a catalog fixture, or the object itself.
   def self.getDataset(fileName)
      hJson = getJson(fileName)
      if hJson.has_key?('dataset')
         hJson['dataset'].first
      else
         hJson
      end
   end

end
