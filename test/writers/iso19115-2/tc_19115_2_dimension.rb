# MdTranslator - minitest of
# writers / iso19115_2 / class_dimension

# History:
#   Stan Smith 2016-11-23 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

# TODO finish after MD_GridSpatialRepresentation
class TestWriter191152Dimension < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_dimension.xml')
    file = File.new(fname)
    @@iso_2_xml = Document.new(file)

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_dimension.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_dimension

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:axisDimensionProperties') {|e| aRefXML << e}

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        # TODO remove file write line
        File.open('/mnt/hgfs/Projects/writeOut.xml', 'w') { |file| file.write(metadata.to_s) }
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:axisDimensionProperties') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

end
