require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsModified < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('modified.json')
   @@jsonIn2 = TestWriterDcatUsParent.getJson('modified2.json')

   def test_modified_basic
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:modified']

      assert_equal '2017-06-22T16:15:14+00:00', got
   end

   def test_modified_out_of_order
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn2, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:modified']

      assert_equal '2022-06-22T16:15:14+00:00', got
   end
   
end
