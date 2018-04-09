# mdJson 2.0 writer tests - taxonomic voucher

# History:
#   Stan Smith 2017-03-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'mdjson_test_parent'

class TestWriterMdJsonVoucher < TestWriterMdJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterMdJsonParent.getJson('voucher.json')

   # TODO reinstate after schema update
   # def test_schema_voucher
   #
   #    hIn = JSON.parse(@@jsonIn)
   #    hTest = hIn['metadata']['resourceInfo']['taxonomy']['voucher'][0]
   #    errors = TestWriterMdJsonParent.testSchema(hTest, 'taxonomy.json', :fragment=>'voucher')
   #    assert_empty errors
   #
   # end

   def test_complete_voucher

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'none', writer: 'mdJson', showAllTags: false)

      expect = JSON.parse(@@jsonIn)
      expect = expect['metadata']['resourceInfo']['taxonomy'][0]['voucher']
      got = JSON.parse(metadata[:writerOutput])
      got = got['metadata']['resourceInfo']['taxonomy'][0]['voucher']

      assert_equal expect, got

   end

end
