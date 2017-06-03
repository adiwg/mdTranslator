# sbJson 1 writer tests - tags

# History:
#  Stan Smith 2017-05-31 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonTag < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('tag.json')

   def test_tags

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'type' => 'Resource Type',
            'name' => 'myType'
         },
         {
            'type' => 'Resource Type',
            'name' => 'Project'
         },
         {
            'type' => 'Resource Type',
            'name' => 'Data'
         },
         {
            'type' => 'Resource Type',
            'name' => 'Report'
         },
         {
            'type' => 'Resource Type',
            'name' => 'factSheet'
         },
         {
            'type' => 'Resource Type',
            'name' => 'presentation'
         },
         {
            'type' => 'Resource Type',
            'name' => 'Physical Item'
         },
         {
            'name' => 'keyword00'
         },
         {
            'name' => 'keyword01'
         },
         {
            'type' => 'keywordType1',
            'name' => 'keyword10',
            'scheme' => 'http://ISO.uri/adiwg/1'
         },
         {
            'type' => 'keywordType1',
            'name' => 'keyword11',
            'scheme' => 'http://ISO.uri/adiwg/1'
         },
         {
            'type' => 'ISO 19115 Topic Categories',
            'name' => 'oceans',
            'scheme' => 'ISO 19115 Topic Categories'
         },
         {
            'type' => 'ISO 19115 Topic Categories',
            'name' => 'extraTerrestrial',
            'scheme' => 'ISO 19115 Topic Categories'
         },
         {
            'type' => 'ISO 19115 Topic Categories',
            'name' => 'structure',
            'scheme' => 'ISO 19115 Topic Categories'
         },
         {
            'type' => 'Project Status',
            'name' => 'Completed'
         },
         {
            'type' => 'Project Status',
            'name' => 'In Progress'
         },
         {
            'type' => 'Project Status',
            'name' => 'Approved'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['tags']

      assert_equal expect, got

   end

end


