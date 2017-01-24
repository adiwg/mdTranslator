# MdTranslator - minitest of
# writers / iso19110 / class_contact

# History:
#   Stan Smith 2017-01-23 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter19110Contact < MiniTest::Test

    # read the ISO 19110 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_contact.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmd:contactInfo') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19110_contact.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19110_contact_individual_complete

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:contactInfo')

        assert_equal @@aRefXML[0].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19110_contact_single_elements

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(2)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(2)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:contactInfo')

        assert_equal @@aRefXML[1].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19110_contact_empty_elements

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(3)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:contactInfo')

        assert_equal @@aRefXML[2].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19110_contact_missing_elements

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:contactInfo')

        assert_equal @@aRefXML[3].to_s.squeeze, checkXML.to_s.squeeze

    end

end
