require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsTemporal < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('temporal.json')

   def test_Temporal
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:temporal']

      expect = 'Temporal'

      assert_equal expect, got
   end
   
end
