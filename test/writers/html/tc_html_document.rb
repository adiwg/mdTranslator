# html 2.0 writer tests - document

# History:
#   Stan Smith 2017-03-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'

class TestHtmlDocument < MiniTest::Test

   # get input JSON for test
   fname = File.join(File.dirname(__FILE__), 'testData', 'metadataGeo.json')
   file = File.open(fname, 'r')
   @@mdJson = file.read
   file.close

   def test_complete_document

      metadata = ADIWG::Mdtranslator.translate(
         file: @@mdJson, reader: 'mdJson', validate: 'none', writer: 'html', showAllTags: false)

      got = metadata[:writerOutput]

      refute_empty got

   end

end
