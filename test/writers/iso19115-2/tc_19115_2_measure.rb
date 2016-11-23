# MdTranslator - minitest of
# adiwg / mdtranslator / writers / iso19115_2 / classes / class_measure

# History:
#   Stan Smith 2016-11-19 original script

require 'minitest/autorun'
require 'builder'
require 'rexml/document'
require 'adiwg/mdtranslator/writers/iso19115_2/classes/class_measure'
include REXML

class TestWriter191152Measure < MiniTest::Test

    # set variables for test
    @@NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2::Measure

    # read the ISO 19115-2 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19115_2_measure.xml')
    file = File.new(fname)
    iso_2_xml = Document.new(file)
    iso_2_xml.context[:attribute_quote] = :quote
    @@aRefXML = []
    XPath.each(iso_2_xml, '//gmd:resolution') {|e| @@aRefXML << e}

    @@intObj = {
        type: 'distance',
        value: 15,
        unitOfMeasure: 'meter'
    }

    def test_19115_2_measure

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        metadata = measureClass.writeXML(@@intObj)

        refXML = @@aRefXML[0].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_missing_type

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:type] = nil
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[1].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_missing_value

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:value] = nil
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[1].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_missing_uom

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:unitOfMeasure] = nil
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[1].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_angle

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:type] = 'angle'
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[2].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_length

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:type] = 'length'
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[3].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_measure

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:type] = 'measure'
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[4].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

    def test_19115_2_measure_invalid_type

        # create new XML document
        xml = Builder::XmlMarkup.new(indent: 3)
        measureClass = @@NameSpace.new(xml, {})

        hIn = Marshal::load(Marshal.dump(@@intObj))
        hIn[:type] = 'invalid'
        metadata = measureClass.writeXML(hIn)

        refXML = @@aRefXML[1].to_s.strip.gsub(/>\s+</,"><")
        checkXML = metadata.to_s.strip.gsub(/>\s+</,"><")

        assert_equal refXML, checkXML

    end

end
