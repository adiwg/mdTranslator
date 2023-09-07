require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsSAMPLE < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('SAMPLE.json')

   def test_sample
      # metadata = ADIWG::Mdtranslator.translate(
      #    file: @@jsonIn, reader: 'mdJson', validate: 'normal',
      #    writer: 'dcat_us', showAllTags: false)

      # hJsonOut = JSON.parse(metadata[:writerOutput])
      # got = hJsonOut['dcat:SAMPLE']

      # assert_equal '', got

      assert true
   end
   
end
