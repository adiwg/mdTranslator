# MdTranslator - minitest of
# writers / iso19115_2 / class_resolution

# History:
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-02 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Resolution < TestWriter191152Parent

    # read the ISO 19110 reference file
    @@xFile = TestWriter191152Parent.get_xml('19115_2_resolution.xml')

    # read the mdJson 2.0 file
    @@mdJson = TestWriter191152Parent.get_json('19115_2_resolution.json')

    def test_19115_2_resolution

        axExpect = @@xFile.xpath('//gmd:spatialResolution')

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
        axGot = xMetadata.xpath('//gmd:spatialResolution')

        axExpect.length.times {|i|
            assert_equal axExpect[i].to_s.squeeze(' '), axGot[i].to_s.squeeze(' ')
        }

    end

end
