require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsContactPoint < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('contactPoint.json')

   def test_sample
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['contactPoint']

      expect = {"@type"=>"vcard:Contact", "fn"=>"Stan Smith", "hasEmail"=>"e.mail@address.com1"}

      assert_equal expect, got
   end
   
end
