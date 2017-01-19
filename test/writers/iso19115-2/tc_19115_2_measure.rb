# MdTranslator - minitest of
# writers / iso19115_2 / class_measure

# History:
#   Stan Smith 2016-11-19 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152Measure < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_measure.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmd:resolution') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_measure.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19115_2_measure_distance

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:resolution')

        assert_equal @@aRefXML[0].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_measure_angle

        hJson = JSON.parse(@@mdJson)
        hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
        hResolution['type'] = 'angle'
        hResolution['unitOfMeasure'] = 'angle'
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:resolution')

        assert_equal @@aRefXML[1].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_measure_length

        hJson = JSON.parse(@@mdJson)
        hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
        hResolution['type'] = 'length'
        hResolution['unitOfMeasure'] = 'length'
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:resolution')

        assert_equal @@aRefXML[2].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_measure_measure

        hJson = JSON.parse(@@mdJson)
        hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
        hResolution['type'] = 'measure'
        hResolution['unitOfMeasure'] = 'measure'
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:resolution')

        assert_equal @@aRefXML[3].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_measure_scale

        hJson = JSON.parse(@@mdJson)
        hResolution = hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution']
        hResolution['type'] = 'scale'
        hResolution['unitOfMeasure'] = 'scale'
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:resolution')

        assert_equal @@aRefXML[4].to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_measure_empty

        hJson = JSON.parse(@@mdJson)
        hJson['metadata']['resourceInfo']['spatialRepresentation'][0]['gridRepresentation']['dimension'][0]['resolution'] = {}
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_out = Document.new(metadata)

        checkXML = XPath.first(iso_out, '//gmd:resolution')

        assert_equal @@aRefXML[5].to_s.squeeze, checkXML.to_s.squeeze

    end

end
