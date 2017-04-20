# MdTranslator - minitest of
# writers / iso19115_2 / class_processStep

# History:
#   Stan Smith 2017-01-05 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152ProcessStep < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_processStep.xml')
    file = File.new(fname)
    @@iso_xml = Document.new(file)

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_processStep.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_processStep

        aRefXML = []
        XPath.each(@@iso_xml, '//gmd:processStep') {|e| aRefXML << e}

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_out, '//gmd:processStep') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

end