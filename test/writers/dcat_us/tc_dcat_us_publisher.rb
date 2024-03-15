require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsPublisher < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('publisher.json')
   @@jsonIn2 = TestWriterDcatUsParent.getJson('publisher2.json')

   def test_publisher_responsible_party
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['publisher']

      expect = {"@type"=>"org:Organization", "name"=>"US Geological Survey", "subOrganizationOf"=>{"@type"=>"org:Organization", "name"=>"US Department of the Interior"}}

      assert_equal expect, got
   end

   def test_publisher_resource_distribution
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn2, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['publisher']

      expect = {"@type"=>"org:Organization", "name"=>"Arctic Landscape Conservation Cooperative"}

      assert_equal expect, got
   end
   
end
