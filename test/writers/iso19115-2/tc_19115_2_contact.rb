# MdTranslator - minitest of
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_contact

# History:
#   Stan Smith 2016-11-21 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152Contact < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_contact.xml')
    file = File.new(fname)
    @@iso_2_xml = Document.new(file)

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_contact.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_contact

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:contact') {|e| aRefXML << e}

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:contact') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

end
