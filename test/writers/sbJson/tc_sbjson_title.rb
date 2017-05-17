# sbJson 1 writer tests - title/alternateTitles

# History:
#  Stan Smith 2017-05-15 original script

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'sbjson_test_parent'

class TestWriterTitle < TestWriterSbJsonParent

   # get input JSON for test
   @@jsonIn = TestWriterSbJsonParent.getJson('title.json')

   def test_title

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['title']

      assert_equal 'myCitationTitle', got

   end

   def test_alternateTitle

      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['alternateTitles']

      assert_equal 2, got.length
      assert_equal 'alternateTitle0', got[0]
      assert_equal 'alternateTitle1', got[1]

   end

   def test_alternateTitle_empty

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['resourceInfo']['citation']['alternateTitle'] = []
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['alternateTitles']

      assert_nil got

   end

   def test_alternateTitle_missing

      hJsonIn = JSON.parse(@@jsonIn)
      hJsonIn['metadata']['resourceInfo']['citation'].delete('alternateTitle')
      hIn = hJsonIn.to_json

      metadata = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', validate: 'normal',
         writer: 'sbJson', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['alternateTitles']

      assert_nil got

   end

end


