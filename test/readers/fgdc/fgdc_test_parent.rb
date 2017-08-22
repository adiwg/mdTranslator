# MdTranslator - minitest of
# parent class for all tc_fgdc tests

# History:
# Stan Smith 2017-08-14 original script

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

   # set xDoc for fgdc methods
   # use when testing modules that read data from other fgdc metadata sections
   # ... pass the additional metadata section data in through xDoc
   def self.set_xDoc(xDoc)
      ADIWG::Mdtranslator::Readers::Fgdc::Fgdc.set_xDoc(xDoc)
   end

   # set intObj for test modules
   # use when tests need to read/write to/from internal object sections other
   # ... than the one created by the test
   def self.set_intObj(intObj = nil)
      if intObj.nil?
         # create new internal metadata container for the reader
         intMetadataClass = InternalMetadata.new
         intObj = intMetadataClass.newBase
      end
      ADIWG::Mdtranslator::Readers::Fgdc::Fgdc.set_intObj(intObj)
   end

   # get intObj for assertions of data written to other intObj sections during test
   def self.get_intObj
      ADIWG::Mdtranslator::Readers::Fgdc::Fgdc.get_intObj
   end

end
