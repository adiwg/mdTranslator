# MdTranslator - minitest of
# writers / iso19110 / class_locale

# History:
#   Stan Smith 2017-01-31 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter19110Locale < MiniTest::Test

    # read the ISO 19110 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_locale.xml')
    file = File.new(fname)
    iso_xml = Document.new(file)
    @@aRefXML = []
    XPath.each(iso_xml, '//gmx:locale') {|e| @@aRefXML << e}

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19110_locale.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19110_locale

        hJson = JSON.parse(@@mdJson)
        jsonIn = hJson.to_json

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: jsonIn, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        File.write('/mnt/hgfs/Projects/writeOut.xml', metadata)
        iso_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_out, '//gmx:locale') {|e| aCheckXML << e}

        @@aRefXML.length.times{|i|
            assert_equal @@aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

end
