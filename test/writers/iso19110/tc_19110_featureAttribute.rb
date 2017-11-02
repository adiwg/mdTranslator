# MdTranslator - minitest of
# writers / iso19110 / class_featureAttribute

# History:
#   Stan Smith 2017-02-02 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'adiwg/mdtranslator'
include REXML

class TestWriter19110FeatureAttribute < MiniTest::Test

   # read the ISO 19110 reference file
   fname = File.join(File.dirname(__FILE__), 'resultXML', '19110_featureAttribute.xml')
   file = File.new(fname)
   iso_xml = Document.new(file)
   @@aRefXML = []
   XPath.each(iso_xml, '//gfc:carrierOfCharacteristics') {|e| @@aRefXML << e}

   # read the mdJson 2.0 file
   fname = File.join(File.dirname(__FILE__), 'testData', '19110_featureAttribute.json')
   file = File.open(fname, 'r')
   @@mdJson = file.read
   file.close

   def test_19110_attribute

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'iso19110', showAllTags: true
      )

      metadata = hResponseObj[:writerOutput]
      iso_out = Document.new(metadata)

      aCheckXML = []
      XPath.each(iso_out, '//gfc:carrierOfCharacteristics') {|e| aCheckXML << e}

      @@aRefXML.length.times {|i|
         assert_equal @@aRefXML[i].to_s.squeeze, aCheckXML[i].to_s.squeeze
      }

   end

end
