require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsLandingPage < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('landingPage.json')

   def test_landingPage
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:landingPage']

      expect = 'http://ISO.uri/adiwg/0'

      assert_equal expect, got
   end
   
end
