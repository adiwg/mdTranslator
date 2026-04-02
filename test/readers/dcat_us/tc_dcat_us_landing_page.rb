# MdTranslator - minitest of
# reader / dcat_us / module_landing_page

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_landing_page'

class TestReaderDcatUsLandingPage < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::LandingPage
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_landing_page_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 1, hCitation[:onlineResources].length
      olRes = hCitation[:onlineResources][0]
      assert_equal 'http://www.agency.gov/vegetables', olRes[:olResURI]
      assert_equal 'landingPage', olRes[:olResFunction]
      assert hResponse[:readerExecutionPass]
   end

   def test_landing_page_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('landingPage')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty hCitation[:onlineResources]
   end

end
