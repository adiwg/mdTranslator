# MdTranslator - minitest of
# writers / iso19110 / class_featureConstraint

# History:
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-03 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19110_test_parent'

class TestWriter19110FeatureConstraint < TestWriter19110Parent

   # read the ISO 19110 reference file
   @@xFile = TestWriter19110Parent.get_xml('19110_featureConstraint.xml')

   # read the mdJson 2.0 file
   @@mdJson = TestWriter19110Parent.get_file('19110_featureConstraint.json')

   def test_19110_constraint

      axExpect = @@xFile.xpath('//gfc:constrainedBy')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      axGot = xMetadata.xpath('//gfc:constrainedBy')

      axExpect.length.times {|i|
         assert_equal axExpect[i].to_s.squeeze, axGot[i].to_s.squeeze
      }

   end

end
