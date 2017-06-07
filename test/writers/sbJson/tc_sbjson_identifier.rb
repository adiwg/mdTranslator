# sbJson 1 writer tests - identifier

# History:
#  Stan Smith 2017-05-17 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonIdentifier < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('identifier.json')

   def test_identifier

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'key' => 'myIdentifier0',
            'scheme' => 'mySchema0',
            'type' => 'myDescription0'
         },
         { 'key' => 'myIdentifier1',
           'scheme' => 'mySchema1',
           'type' => 'myDescription1'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['identifiers']

      assert_equal expect, got

   end

end


