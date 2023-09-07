require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsKeyword < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('keyword.json')

   def test_keyword
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:keyword']

      expect = ["Barrow", "Prudhoe Bay", "Kaparuk", "Brown Bear", "Polar Bear", "Black Bear", "Cinnamon Bear", "Teddy Bear", "butter", "sugar", "eggs", "inlandWaters", "location", "climatologyMeteorologyAtmosphere", "carbon dating", "ionization"]

      assert_equal expect, got
   end
   
end
