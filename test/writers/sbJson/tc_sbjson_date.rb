# sbJson 1 writer tests - date

# History:
#  Stan Smith 2017-06-01 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonDate < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('date.json')

   def test_date

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = [
         {
            'type' => 'creation',
            'dateString' => '2017-05',
            'label' => 'Creation Date'
         },
         {
            'type' => 'Publication',
            'dateString' => '2017-05-16',
            'label' => 'Published First Edition'
         },
         {
            'type' => 'revision',
            'dateString' => '2017-05-16T16:10:00-09:00'
         },
         {
            'type' => 'Info',
            'dateString' => '2017-04-15T06:35:00-06:00',
            'label' => 'expiry'
         },
         {
            'type' => 'Start',
            'dateString' => '2016-10-14T11:10:15.200-10:00',
            'label' => 'My Project Period'
         },
         {
            'type' => 'End',
            'dateString' => '2016-12-31',
            'label' => 'My Project Period'
         }
      ]

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dates']

      assert_equal expect, got

   end

end


