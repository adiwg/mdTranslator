# MdTranslator - minitest of
# writers / iso19115_2 / class_miMetadata

# History:
#   Stan Smith 2017-02-01 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
require 'date'
include REXML

class TestWriter191152MetadataDate < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_metadataDate.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmd:dateStamp') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_metadataDate.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_metadataDate

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:dateStamp')

        assert_equal @@aRefXML[0].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_metadataDate_missing_create

        hJson = JSON.parse(@@mdJson)
        hJson['metadata']['metadataInfo']['metadataDate'].delete_at(1)
        jsonIn = hJson.to_json
        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:dateStamp')
        checkXML = XPath.first(checkXML, '//gco:Date').get_text
        today = Time.now.strftime("%Y-%m-%d")

        assert_equal today.to_s, checkXML.to_s

    end

    def test_19115_2_metadataDate_empty

        hJson = JSON.parse(@@mdJson)
        hJson['metadata']['metadataInfo']['metadataDate'] = []
        jsonIn = hJson.to_json
        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:dateStamp')
        checkXML = XPath.first(checkXML, '//gco:Date').get_text
        today = Time.now.strftime("%Y-%m-%d")

        assert_equal today.to_s, checkXML.to_s

    end

    def test_19115_2_metadataDate_missing

        hJson = JSON.parse(@@mdJson)
        hJson['metadata']['metadataInfo'].delete('metadataDate')
        jsonIn = hJson.to_json
        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:dateStamp')
        checkXML = XPath.first(checkXML, '//gco:Date').get_text
        today = Time.now.strftime("%Y-%m-%d")

        assert_equal today.to_s, checkXML.to_s

    end

end
