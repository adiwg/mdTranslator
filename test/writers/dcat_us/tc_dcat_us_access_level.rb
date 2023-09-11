require 'minitest/autorun'
require 'json'
require 'adiwg-mdtranslator'
require_relative 'dcat_us_test_parent'

class TestWriterDcatUsAccessLevel < TestWriterDcatUsParent

   # get input JSON for test
   @@jsonInPub = TestWriterDcatUsParent.getJson('accessLevel_pub.json')
   @@jsonInResPub = TestWriterDcatUsParent.getJson('accessLevel_resPub.json')
   @@jsonInNonPub = TestWriterDcatUsParent.getJson('accessLevel_nonPub.json')

   def test_accessLevel_public
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonInPub, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:accessLevel']

      expect = 'public'

      assert_equal expect, got
   end

   def test_accessLevel_restricted_public
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonInResPub, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:accessLevel']

      expect = 'restricted public'

      assert_equal expect, got
   end

   def test_accessLevel_non_public
      metadata = ADIWG::Mdtranslator.translate(
         file: @@jsonInNonPub, reader: 'mdJson', validate: 'normal',
         writer: 'dcat_us', showAllTags: false)

      hJsonOut = JSON.parse(metadata[:writerOutput])
      got = hJsonOut['dcat:accessLevel']

      expect = 'non-public'

      assert_equal expect, got
   end
   
end
