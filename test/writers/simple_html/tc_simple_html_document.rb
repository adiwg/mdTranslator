require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'

class TestSimpleHtmlDocument < Minitest::Test

   # get input JSON for test
   fname = File.join(File.dirname(__FILE__), 'testData', 'metadataGeo.json')
   file = File.open(fname, 'r')
   @@mdJson = file.read
   file.close

   def test_complete_document

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', validate: 'none', writer: 'simple_html', showAllTags: false)

      got = metadata[:writerOutput]

      refute_empty got

   end

end
