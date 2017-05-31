# sbJson 1 writer tests - contact

# History:
#  Stan Smith 2017-05-25 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonContact < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('contact.json')

   def test_rights

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'name' => 'Person 001', 
            'contactType' => 'person',
            'personalTitle' => 'person001PositionName',
            'type' => 'metadataContact',
            'email' => 'e.mail@address.com0',
            'hours' => 'myHoursOfService 00; myHoursOfService 01',
            'instructions' => 'my Contact Instructions',
            'tty' => '222-222-2222',
            'organization' => {
               'displayText' => 'Organization 001'
            },
            'logoUrl' => 'http://ISO.uri/adiwg/0',
            'primaryLocation' => {
               'officePhone' => '111-111-1111',
               'faxPhone' => '111-111-1111',
               'description' => 'myAddressDescription',
               'streetAddress' => {
                  'line1' => 'deliveryPoint 00',
                  'line2' => 'deliveryPoint 01',
                  'city' => 'myCity',
                  'state' => 'myState',
                  'zip' => 'myPostalCode',
                  'country' => 'myCountry'
               },
               'mailAddress' => {
                  'line1' => 'deliveryPoint 00',
                  'line2' => 'deliveryPoint 01',
                  'city' => 'myCity',
                  'state' => 'myState',
                  'zip' => 'myPostalCode',
                  'country' => 'myCountry'
               }
            }
         },
         {
            'name' => 'Person 003',
            'contactType' => 'person',
            'type' => 'Principal Investigator'
         },
         {
            'name' => 'Person 004',
            'contactType' => 'person',
            'type' => 'Principal Investigator'
         },
         {
            'name' => 'Organization 001',
            'contactType' => 'organization',
            'type' => 'funder'
         },
         {
            'name' => 'Person 003',
            'contactType' => 'person',
            'type' => 'Point of Contact'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['contacts']
      File.write('/mnt/hgfs/ShareDrive/writeOut.json', hJsonOut.to_json)

      assert_equal expect, got

   end

end


