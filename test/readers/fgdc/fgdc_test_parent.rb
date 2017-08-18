# MdTranslator - minitest of
# parent class for all tc_fgdc tests

# History:
# Stan Smith 2017-09-14 original script

require 'minitest/autorun'
require 'rubygems'
require 'nokogiri'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'

class TestReaderFGDCParent < MiniTest::Test

   @@hResponseObj = {
      readerExecutionPass: true,
      readerExecutionMessages: []
   }

   # get fgdc file for testing from test data folder
   def self.get_XML(fileName)

      file = File.join(File.dirname(__FILE__), 'testData', fileName)
      xDoc = Nokogiri::XML(File.read(file))
      return xDoc

   end

   def self.set_xDoc(xDoc)

      ADIWG::Mdtranslator::Readers::Fgdc::Fgdc.set_xDoc(xDoc)

   end

   # set contact list for test modules
   def self.set_intObj

      # create new internal metadata container for the reader
      intMetadataClass = InternalMetadata.new
      intObj = intMetadataClass.newBase

      ADIWG::Mdtranslator::Readers::Fgdc::Fgdc.set_intObj(intObj)

   end

end
