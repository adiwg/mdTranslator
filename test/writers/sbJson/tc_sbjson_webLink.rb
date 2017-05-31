# sbJson 1 writer tests - webLinks

# History:
#  Stan Smith 2017-05-31 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbWebLink < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('webLink.json')

   def test_webLinks

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'type' => 'download', 
            'typeLabel' => 'myDescription1', 
            'uri' => 'http://ISO.uri/adiwg/1', 
            'title' => 'myName1'
         }, 
         {
            'type' => 'download', 
            'uri' => 'http://ISO.uri/adiwg/2'
         }, 
         {
            'type' => 'webapp', 
            'typeLabel' => 'myDescription3', 
            'uri' => 'http://ISO.uri/adiwg/3', 
            'title' => 'myName1'
         }, 
         {
            'type' => 'browseImage', 
            'typeLabel' => 'myDescription4', 
            'uri' => 'http://ISO.uri/adiwg/4', 
            'title' => 'myName4'
         }, 
         {
            'type' => 'browseImage', 
            'typeLabel' => 'myDescription5', 
            'uri' => 'http://ISO.uri/adiwg/5', 
            'title' => 'myName5'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['webLinks']

      assert_equal expect, got

   end

end


