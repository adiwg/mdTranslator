# MdTranslator - minitest of
# writers / fgdc / class_fgdc

# History:
#   Stan Smith 2017-11-16 original script

require 'minitest/autorun'
require 'json'
require 'rexml/document'
require 'rubygems'
require 'adiwg/mdtranslator'
require 'adiwg/mdtranslator/writers/fgdc/version'
include REXML

class TestWriterFgdcFgdc < MiniTest::Test

   # read the mdJson 2.0 file
   fname = File.join(File.dirname(__FILE__), 'testData', 'fgdc.json')
   file = File.open(fname, 'r')
   @@mdJson = file.read
   file.close

   def test_fgdc

      # read the fgdc complete reference file
      fname = File.join(File.dirname(__FILE__), 'resultXML', 'fgdc.xml')
      file = File.new(fname)
      iso_xml = Document.new(file)
      refXML = XPath.first(iso_xml, '//metadata')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      translatorVersion = ADIWG::Mdtranslator::VERSION
      writerVersion = ADIWG::Mdtranslator::Writers::Fgdc::VERSION
      schemaVersion = Gem::Specification.find_by_name('adiwg-mdjson_schemas').version.to_s

      assert_equal 'mdJson', hResponseObj[:readerRequested]
      assert_equal '2.0.0', hResponseObj[:readerVersionRequested]
      assert_equal schemaVersion, hResponseObj[:readerVersionUsed]
      assert hResponseObj[:readerStructurePass]
      assert_empty hResponseObj[:readerStructureMessages]
      assert_equal 'normal', hResponseObj[:readerValidationLevel]
      assert hResponseObj[:readerValidationPass]
      assert_empty hResponseObj[:readerValidationMessages]
      assert hResponseObj[:readerExecutionPass]
      assert_empty hResponseObj[:readerExecutionMessages]
      assert_equal 'fgdc', hResponseObj[:writerRequested]
      assert_equal writerVersion, hResponseObj[:writerVersion]
      assert hResponseObj[:writerPass]
      assert_equal 'xml', hResponseObj[:writerOutputFormat]
      assert hResponseObj[:writerShowTags]
      assert_nil hResponseObj[:writerCSSlink]
      assert_equal '_000', hResponseObj[:writerMissingIdCount]
      assert_equal translatorVersion, hResponseObj[:translatorVersion]

      metadata = hResponseObj[:writerOutput]
      iso_out = Document.new(metadata)
      checkXML = XPath.first(iso_out, '//metadata')

      assert_equal refXML.to_s.squeeze, checkXML.to_s.squeeze

   end

end
