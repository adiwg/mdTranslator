require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsIdentifier < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('identifier.json')
   @@jsonIn2 = TestWriterDcatUsParent.getJson('identifier2.json')

   def test_identifier_namespace
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:identifier']

      assert_equal 'http://myOnlineResource-namespace.com', got
   end

   def test_identifier_url
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn2, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:identifier']

      assert_equal 'http://myOnlineResource-doi.com', got
   end

end
