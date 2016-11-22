# MdTranslator - minitest of
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_locale

# History:
#   Stan Smith 2016-11-22 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152Locale < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_locale.xml')
    file = File.new(fname)
    @@iso_2_xml = Document.new(file)

    def test_19115_2_locale

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:locale') {|e| aRefXML << e}

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_locale.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:locale') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

    def test_19115_2_locale_empty

        refXML = '<gmd:locale/>'

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_locale.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        # empty language
        # delete otherMetadataLocale
        hJson = JSON.parse(mdJson)
        hJson['mdJson']['metadata']['metadataInfo']['defaultMetadataLocale'] = {}
        hJson['mdJson']['metadata']['metadataInfo']['otherMetadataLocale'] = []
        jsonIn = hJson.to_json
        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        checkXML = XPath.first(iso_2_out, '//gmd:locale')

        assert_equal refXML.to_s.squeeze, checkXML.to_s.squeeze

    end

    def test_19115_2_locale_missing

        refXML = '<gmd:locale/>'

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_locale.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        # empty language
        # delete otherMetadataLocale
        hJson = JSON.parse(mdJson)
        hJson['mdJson']['metadata']['metadataInfo'].delete('defaultMetadataLocale')
        hJson['mdJson']['metadata']['metadataInfo'].delete('otherMetadataLocale')
        jsonIn = hJson.to_json
        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        checkXML = XPath.first(iso_2_out, '//gmd:locale')

        assert_equal refXML.to_s.squeeze, checkXML.to_s.squeeze

    end

end
