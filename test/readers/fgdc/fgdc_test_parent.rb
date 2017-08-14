# MdTranslator - minitest of
# parent class for all tc_fgdc tests

# History:
# Stan Smith 2017-09-14 original script

require 'minitest/autorun'
require 'rubygems'
require 'nokogiri'
require 'adiwg/mdtranslator'

class TestReaderFGDCParent < MiniTest::Test

   @@hResponseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # get fgdc file for testing from test data folder
   def self.getXML(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      xDoc = Nokogiri::XML(File.read(file))
      return xDoc

   end

end
