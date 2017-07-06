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

   def test_contact

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'name' => 'Person 1',
            'contactType' => 'person',
            'personalTitle' => 'person 1 Position Name',
            'type' => 'Metadata Contact',
            'email' => 'e.mail@address.com0',
            'hours' => 'myHoursOfService 00; myHoursOfService 01',
            'instructions' => 'my Contact Instructions',
            'officePhone' => '111-111-1111',
            'faxPhone' => '111-111-1111',
            'ttyPhone' => '222-222-2222',
            'organization' => {
               'displayText' => 'Organization 1'
            },
            'logoUrl' => 'http://ISO.uri/adiwg/0',
            'primaryLocation' => {
               'officePhone' => '111-111-1111',
               'faxPhone' => '111-111-1111',
               'ttyPhone' => '222-222-2222',
               'description' => 'myAddressDescription',
               'streetAddress' =>
                  {
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
            'name' => 'Person 3',
            'contactType' => 'person',
            'type' => 'Principal Investigator'
         },
         {
            'name' => 'Person 4',
            'contactType' => 'person',
            'type' => 'Principal Investigator'
         },
         {
            'name' => 'Organization 1',
            'contactType' => 'organization',
            'type' => 'funder'
         },
         {
            'name' => 'Person 3',
            'contactType' => 'person',
            'type' => 'Co-Investigator'
         },
         {
            'name' => 'Person 3',
            'contactType' => 'person',
            'type' => 'Point of Contact'
         },
         {
            'name' => 'Person 2',
            'contactType' => 'person',
            'type' => 'Distributor',
            'primaryLocation' =>
               {
                  'description' => 'yourAddressDescription',
                  'mailAddress' =>
                     {
                        'line1' => 'deliveryPoint 01',
                        'city' => 'yourCity',
                        'state' => 'yourState',
                        'zip' => 'yourPostalCode',
                        'country' => 'yourCountry'
                     }
               }
         },
         {
            'name' => 'Person 3',
            'contactType' => 'person',
            'type' => 'userProvided'
         },
         {
            'name' => 'Person 4',
            'contactType' => 'person',
            'type' => 'SoftwareEngineer'
         },
         {
            'name' => 'Person 2',
            'contactType' => 'person',
            'type' => 'Material Request Contact',
            'primaryLocation' =>
               {
                  'description' => 'yourAddressDescription',
                  'mailAddress' =>
                     {
                        'line1' => 'deliveryPoint 01',
                        'city' => 'yourCity',
                        'state' => 'yourState',
                        'zip' => 'yourPostalCode',
                        'country' => 'yourCountry'
                     }
               }
         },
         {
            'name' => 'Person 3',
            'contactType' => 'person',
            'type' => 'Material Request Contact'
         },
         {
            'name' => 'Person 4',
            'contactType' => 'person',
            'type' => 'Material Request Contact'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['contacts']

      assert_equal expect, got

   end

end


