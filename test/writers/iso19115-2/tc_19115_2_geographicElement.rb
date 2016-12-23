# MdTranslator - minitest of
# writers / iso19115_2 / class_geographicElement

# History:
#   Stan Smith 2016-12-22 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152GeographicElement < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_geographicElement.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmd:geographicElement') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_geographicElement.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_geographicElement

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_out, '//gmd:geographicElement') {|e| aCheckXML << e}

        @@aRefXML.length.times{|i|
            assert_equal @@aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

end
