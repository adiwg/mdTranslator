# MdTranslator - minitest of
# writers / iso19115_2 / class_maintenance

# History:
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-05 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Maintenance < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_maintenance.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_file('19115_2_maintenance.json')

   def test_19115_2_maintenance

      axExpect = @@xFile.xpath('//gmd:MD_MaintenanceInformation')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gmd:MD_MaintenanceInformation')

      axExpect.length.times {|i|
         assert_equal axExpect[i].to_s.squeeze, axGot[i].to_s.squeeze
      }

   end

end
