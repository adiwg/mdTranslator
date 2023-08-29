# dcat_us 1 writer tests - title/alternateTitles

# History:
# 

require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsTitle < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonIn = TestWriterDcatUsParent.getJson('title.json')

   def test_title
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonIn, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:title']

      assert_equal 'myCitationTitle', got

   end

   # def test_alternateTitle

   #    metadata = ADIWG::Mdtranslator.translate(
   #       file: @@jsonIn, reader: 'mdJson', validate: 'normal',
   #       writer: 'dcat_us', showAllTags: false)

   #    hJsonOut = JSON.parse(metadata[:writerOutput])
   #    got = hJsonOut['alternateTitles']

   #    assert_equal 2, got.length
   #    assert_equal 'alternateTitle0', got[0]
   #    assert_equal 'alternateTitle1', got[1]

   # end

   # def test_alternateTitle_empty

   #    hJsonIn = JSON.parse(@@jsonIn)
   #    hJsonIn['metadata']['resourceInfo']['citation']['alternateTitle'] = []
   #    hIn = hJsonIn.to_json

   #    metadata = ADIWG::Mdtranslator.translate(
   #       file: hIn, reader: 'mdJson', validate: 'normal',
   #       writer: 'dcat_us', showAllTags: false)

   #    hJsonOut = JSON.parse(metadata[:writerOutput])
   #    got = hJsonOut['alternateTitles']

   #    assert_nil got

   # end

   # def test_alternateTitle_missing

   #    hJsonIn = JSON.parse(@@jsonIn)
   #    hJsonIn['metadata']['resourceInfo']['citation'].delete('alternateTitle')
   #    hIn = hJsonIn.to_json

   #    metadata = ADIWG::Mdtranslator.translate(
   #       file: hIn, reader: 'mdJson', validate: 'normal',
   #       writer: 'dcat_us', showAllTags: false)

   #    hJsonOut = JSON.parse(metadata[:writerOutput])
   #    got = hJsonOut['alternateTitles']

   #    assert_nil got

   # end

end
