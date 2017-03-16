# mdJson 2.0 writer tests - date time

# History:
#   Stan Smith 2017-03-16 original script

# not all date formats are testable using these methods
# ... date formats with 'Z' input output as '+00:00'
# ... date formats with fractional seconds always out put to 3 decimal places
# ... dates with zone offset '-9' input outputs as '-09:00'
# and all these are correct, but eliminated from the test input file

require 'minitest/autorun'
require 'json/pure'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterDateTime < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('dateTime.json')

   def test_complete_dateTime

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['metadataInfo']['metadataDate']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['metadataInfo']['metadataDate']

      assert_equal expect, got

   end

end
