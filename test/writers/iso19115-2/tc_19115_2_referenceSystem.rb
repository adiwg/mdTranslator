# MdTranslator - minitest of
# writers / iso19115_2 / class_referenceSystem

# History:
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-09 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152ReferenceSystem < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_referenceSystem.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_json('19115_2_referenceSystem.json')

   def test_19115_2_referenceSystem

      axExpect = @@xFile.xpath('//gmd:referenceSystemInfo')

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate( validate: 'none',
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:referenceSystemInfo')

      axExpect.length.times {|i|
         assert_equal axExpect[i].to_s.squeeze(' '), axGot[i].to_s.squeeze(' ')
      }

   end

end
