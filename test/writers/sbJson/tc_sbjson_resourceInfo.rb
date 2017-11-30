# sbJson 1 writer tests - body/summary

# History:
#  Stan Smith 2017-05-16 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterSbJsonBody < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('resourceInfo.json')

   def test_body

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      expect = '<h3 id="title">Title</h3><p><strong>BOLD</strong></p><ul>  <li>Item 1</li>  <li>Item 2</li></ul><p>Whitespace paragraph 1</p><p>Whitespace paragraph 2</p>'
      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['body']

      assert_equal expect, got

   end

   def test_purpose

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['purpose']

      assert_equal 'myPurpose', got

   end

end


