# sbJson 1 writer tests - webLinks

# History:
#  Stan Smith 2017-05-31 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonWebLink < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('webLink.json')

   def test_webLinks

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'type' => 'download',
            'typeLabel' => 'translated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/1',
            'title' => 'myName1'
         },
         {
            'type' => 'webLink',
            'typeLabel' => 'missing function code',
            'uri' => 'http://ISO.uri/adiwg/2'
         },
         {
            'type' => 'webapp',
            'typeLabel' => 'translated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/3',
            'title' => 'myName13'
         },
         {
            'type' => 'browseImage',
            'typeLabel' => 'translated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/4',
            'title' => 'myName4'
         },
         {
            'type' => 'browseImage',
            'typeLabel' => 'translated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/5',
            'title' => 'myName5'
         },
         {
            'type' => 'download',
            'typeLabel' => 'translated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/6',
            'title' => 'myName6'
         },
         {
            'type' => 'fileAccess',
            'typeLabel' => 'translated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/7',
            'title' => 'myName7'
         },
         {
            'type' => 'webLink',
            'typeLabel' => 'untranslated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/8',
            'title' => 'myName8'
         },
         {
            'type' => 'webLink',
            'typeLabel' => 'untranslated adiwg code',
            'uri' => 'http://ISO.uri/adiwg/9',
            'title' => 'myName9'
         },
         {
            'type' => 'serviceMapUri',
            'typeLabel' => 'untranslated sb type',
            'uri' => 'http://ISO.uri/adiwg/10',
            'title' => 'myName10'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['webLinks']

      assert_equal expect, got

   end

end


