# MdTranslator - minitest of
# writers / iso19115_2 / class_taxonomicClassification

# History:
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TaxonomicClassification < TestWriter191152Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter191152Parent.get_xml('19115_2_taxonomicClassification.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter191152Parent.get_json('19115_2_taxonomicClassification.json')

   def test_19115_2_taxonomicClassification

      xExpect = @@xFile.xpath('//gmd:taxonomy')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('//gmd:taxonomy')

      assert_equal xExpect.to_s.squeeze(' '), xGot.to_s.squeeze(' ')

   end

end
