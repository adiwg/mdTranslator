# MdTranslator - minitest of
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_responsibleParty
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_phone
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_onlineResource
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_contact

# History:
#   Stan Smith 2016-11-16 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152ResponsibleParty < MiniTest::Test

    # read the ISO 19115-2 XML reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_responsibleParty.xml')
    file = File.new(fname)
    @@iso_2_xml = Document.new(file)

    def test_19115_2_responsibleParty

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:contact') {|e| aRefXML << e}

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', 'mdJson_responsibleParty.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
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
