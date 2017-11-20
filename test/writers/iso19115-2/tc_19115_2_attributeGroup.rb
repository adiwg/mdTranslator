# MdTranslator - minitest of
# writers / iso19115_2 / class_attributeGroup

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2016-12-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152AttributeGroup < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_attributeGroup.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_file('19115_2_attributeGroup.json')

   # read the ISO 19115-2 reference file
   def test_19115_2_attributeGroup

      axExpect = @@xFile.xpath('//gmi:MI_CoverageDescription')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmi:MI_CoverageDescription')

      axExpect.length.times {|i|
         assert_equal axExpect[i].to_s.squeeze, axGot[i].to_s.squeeze
      }

   end

end
