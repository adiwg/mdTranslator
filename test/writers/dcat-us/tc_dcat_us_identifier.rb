# dcat-us 1 writer tests - identifier

# History:
#  

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsIdentifier < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('identifier.json')

   def test_identifier

      hJsonIn = JSON.parse(@@jsonIn)
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

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

   # def test_identifier_include_metadataIdentifier

   #    hJsonIn = JSON.parse(@@jsonIn)
   #    hJsonIn['metadata']['metadataInfo']['metadataIdentifier']['namespace'] = 'ABC'
   #    hIn = hJsonIn.to_json

   #    metadata = ADIWG::Mdtranslator.translate(
   #       file: hIn, reader: 'mdJson', validate: 'normal',
   #       writer: 'dcat_us', showAllTags: false)

   #    expect = [
   #       {
   #          'key' => 'myMetadataIdentifierID',
   #          'scheme' => 'ABC',
   #          'type' => 'metadata identifier'
   #       },
   #       {
   #          'key' => 'myIdentifier0',
   #          'scheme' => 'mySchema0',
   #          'type' => 'myDescription0'
   #       },
   #       { 'key' => 'myIdentifier1',
   #         'scheme' => 'mySchema1',
   #         'type' => 'myDescription1'
   #       }
   #    ]

   #    hJsonOut = JSON.parse(metadata[:writerOutput])
   #    got = hJsonOut['identifiers']

   #    assert_equal expect, got

   # end

end
