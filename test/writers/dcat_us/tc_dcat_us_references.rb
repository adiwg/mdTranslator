require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsReferences < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('references.json')

   def test_references
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:references']

      expect = 'http://ISO.uri/adiwg/0,http://ISO.uri/adiwg/1,http://ISO.uri/adiwg/2,http://ISO.uri/adiwg/3,http://ISO.uri/adiwg/4,http://ISO.uri/adiwg/5,http://ISO.uri/adiwg/6,http://ISO.uri/adiwg/7,http://ISO.uri/adiwg/8,http://ISO.uri/adiwg/9,http://ISO.uri/adiwg/10,http://ISO.uri/adiwg/11'

      assert_equal expect, got
   end
   
end
