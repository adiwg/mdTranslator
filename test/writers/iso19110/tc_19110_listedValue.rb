# MdTranslator - minitest of
# writers / iso19110 / class_listedValue

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-03 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19110_test_parent'

class TestWriter19110ListedValue < TestWriter19110Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter19110Parent.get_xml('19110_listedValue.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_json('19110_listedValue.json')

   def test_19110_listedValue

      axExpect = @@xFile.xpath('//gfc:carrierOfCharacteristics')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gfc:carrierOfCharacteristics')

      axExpect.length.times {|i|
         assert_equal axExpect[i].to_s.squeeze(' '), axGot[i].to_s.squeeze(' ')
      }

   end

end
