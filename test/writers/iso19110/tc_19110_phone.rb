# MdTranslator - minitest of
# writers / iso19110 / class_phone

# History:
#   Stan Smith 2017-02-01 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter19110Phone < MiniTest::Test

    # read the ISO 19110 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_phone.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmd:phone') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19110_phone.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19110_phone_single

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:phone')

        assert_equal @@aRefXML[0].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19110_phone_multiple

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(1)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:phone')

        assert_equal @@aRefXML[1].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19110_phone_unknown

        hJson = JSON.parse(@@mdJson)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        hJson['dataDictionary'][0]['responsibleParty']['party'].delete_at(0)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:phone')

        assert_equal @@aRefXML[2].to_s.squeeze, checkXML.to_s.squeeze

    end

end
