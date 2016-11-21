# MdTranslator - minitest of
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_scope

# History:
#   Stan Smith 2016-11-21 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter191152Scope < MiniTest::Test

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_scope.xml')
    file = File.new(fname)
    @@iso_2_xml = Document.new(file)

    def test_19115_2_hierarchyLevel

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:hierarchyLevel') {|e| aRefXML << e}

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_scope.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:hierarchyLevel') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

    def test_19115_2_hierarchyLevelName

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:hierarchyLevelName') {|e| aRefXML << e}

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_scope.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: mdJson, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:hierarchyLevelName') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

    def test_19115_2_scope_empty_resourceScope

        refXML1 = '<gmd:hierarchyLevel/>'
        refXML2 = '<gmd:hierarchyLevelName/>'

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_scope.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close
        # remove element metadataIdentifier
        hJson = JSON.parse(mdJson)
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'] = []
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        checkXML1 = XPath.first(iso_2_out, '//gmd:hierarchyLevel')
        checkXML2 = XPath.first(iso_2_out, '//gmd:hierarchyLevelName')

        assert_equal refXML1.to_s.squeeze, checkXML1.to_s.squeeze
        assert_equal refXML2.to_s.squeeze, checkXML2.to_s.squeeze

    end

    def test_19115_2_scope_missing_resourceScope

        refXML1 = '<gmd:hierarchyLevel/>'
        refXML2 = '<gmd:hierarchyLevelName/>'

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_scope.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close
        # remove element metadataIdentifier
        hJson = JSON.parse(mdJson)
        hJson['mdJson']['metadata']['metadataInfo'].delete('resourceScope')
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        checkXML1 = XPath.first(iso_2_out, '//gmd:hierarchyLevel')
        checkXML2 = XPath.first(iso_2_out, '//gmd:hierarchyLevelName')

        assert_equal refXML1.to_s.squeeze, checkXML1.to_s.squeeze
        assert_equal refXML2.to_s.squeeze, checkXML2.to_s.squeeze

    end

    def test_19115_2_scope_empty_scopeDescription

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:hierarchyLevel') {|e| aRefXML << e}
        refXML2 = '<gmd:hierarchyLevelName/>'

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_scope.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        # empty scopeDescription
        # delete timePeriod
        hJson = JSON.parse(mdJson)
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][0]['scopeDescription'] = []
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][0].delete('timePeriod')
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][1]['scopeDescription'] = []
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][1].delete('timePeriod')
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:hierarchyLevel') {|e| aCheckXML << e}
        checkXML2 = XPath.first(iso_2_out, '//gmd:hierarchyLevelName')

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }
        assert_equal refXML2.to_s.squeeze, checkXML2.to_s.squeeze

    end

    def test_19115_2_scope_missing_scopeDescription

        aRefXML = []
        XPath.each(@@iso_2_xml, '//gmd:hierarchyLevel') {|e| aRefXML << e}
        refXML2 = '<gmd:hierarchyLevelName/>'

        # read the mdJson 2.0 file
        fname = File.join(File.dirname(__FILE__), 'testData', '19115_2_scope.json')
        file = File.open(fname, 'r')
        mdJson = file.read
        file.close

        # delete scopeDescription
        # delete timePeriod
        hJson = JSON.parse(mdJson)
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][0].delete('scopeDescription')
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][0].delete('timePeriod')
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][1].delete('scopeDescription')
        hJson['mdJson']['metadata']['metadataInfo']['resourceScope'][1].delete('timePeriod')
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19115_2', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        iso_2_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_2_out, '//gmd:hierarchyLevel') {|e| aCheckXML << e}
        checkXML2 = XPath.first(iso_2_out, '//gmd:hierarchyLevelName')

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }
        assert_equal refXML2.to_s.squeeze, checkXML2.to_s.squeeze

    end

end
