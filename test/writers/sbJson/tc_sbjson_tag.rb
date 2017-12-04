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
            'type' => 'theme',
            'name' => 'The quick brown fox jumped over the lazy dog. The quick brown fox jumped ove...'
         },
         {
            'type' => 'theme',
            'name' => 'first word'
         },
         {
            'type' => 'theme',
            'name' => 'second word'
         },
         {
            'type' => 'theme',
            'name' => 'third word'
         },
         {
            'type' => 'theme',
            'name' => 'fourth word'
         },
         {
            'type' => 'theme',
            'name' => 'fifth word'
         },
         {
            'type' => 'theme',
            'name' => 'sixth word'
         },
         {
            'type' => 'theme',
            'name' => 'seventh word'
         },
         {
            'type' => 'theme',
            'name' => 'eighth word'
         },
         {
            'type' => 'Status',
            'name' => 'completed'
         },
         {
            'type' => 'Status',
            'name' => 'onGoing'
         },
         {
            'type' => 'Status',
            'name' => 'underDevelopment'
         },
         {
            'type' => 'Harvest Set',
            'name' => 'Arctic LCC Data.gov'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['tags']

      assert_equal expect, got

   end

end
