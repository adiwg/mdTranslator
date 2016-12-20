# MdTranslator - minitest of
# writers / iso19115_2 / class_citation

# History:
#   Stan Smith 2016-12-19 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152Citation < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_citation.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmd:citation') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_citation.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_citation

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:citation')

        assert_equal @@aRefXML[0].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_citation_no_dash_1

        hJson = JSON.parse(@@mdJson)
        hCitation = hJson['mdJson']['metadata']['resourceInfo']['citation']
        hCitation.delete('onlineResource')
        hCitation.delete('graphic')
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:citation')

        assert_equal @@aRefXML[0].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_citation_empty_elements

        hJson = JSON.parse(@@mdJson)
        hCitation = hJson['mdJson']['metadata']['resourceInfo']['citation']
        hCitation.delete('alternateTitle')
        hCitation.delete('date')
        hCitation.delete('onlineResource')
        hCitation.delete('edition')
        hCitation.delete('responsibleParty')
        hCitation.delete('presentationForm')
        hCitation.delete('identifier')
        hCitation.delete('series')
        hCitation.delete('otherCitationDetails')
        hCitation.delete('onlineResource')
        hCitation.delete('graphic')
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:citation')

        assert_equal @@aRefXML[1].to_s.squeeze, checkXML.to_s.squeeze

    end

end
