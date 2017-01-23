# MdTranslator - minitest of
# writers / iso19110 / class_fcFeatureCatalogue

# History:
#   Stan Smith 2017-01-20 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter19110FCFeatureCatalogue < MiniTest::Test

    # read the ISO 19110 reference file
    fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_fcFeatureCatalogue.xml')
    file = File.new(fname)
    @@iso_xml = Document.new(file)

    # read the mdJson 2.0 file
    fname = File.join(File.dirname(__FILE__), 'testData', '19110_fcFeatureCatalogue.json')
    file = File.open(fname, 'r')
    @@mdJson = file.read
    file.close

    def test_19110_fcFeatureCatalogue

        aRefXML = []
        XPath.each(@@iso_xml, '//gmd:contentInfo') {|e| aRefXML << e}

        hResponseObj = ADIWG::Mdtranslator.translate(
            file: @@mdJson, reader: 'mdJson', writer: 'iso19110', showAllTags: true
        )

        metadata = hResponseObj[:writerOutput]
        File.write('/mnt/hgfs/Projects/writeOut.xml', metadata)
        iso_out = Document.new(metadata)

        aCheckXML = []
        XPath.each(iso_out, '//gmd:contentInfo') {|e| aCheckXML << e}

        aRefXML.length.times{|i|
            assert_equal aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
        }

    end

end
