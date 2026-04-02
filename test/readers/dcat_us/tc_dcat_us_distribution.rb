# MdTranslator - minitest of
# reader / dcat_us / module_distribution

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_distribution'

class TestReaderDcatUsDistribution < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Distribution
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_distribution_complete
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hMetadata = @@intMetadataClass.newMetadata

      @@NameSpace.unpack(hIn, hMetadata, hResponse)

      # Two distributions in fixture (accessURL + downloadURL)
      assert_equal 2, hMetadata[:distributorInfo].length

      # First distribution: accessURL
      dist1 = hMetadata[:distributorInfo][0]
      assert_equal 'A fully queryable REST API with JSON and XML output', dist1[:description]
      uri1 = dist1[:distributor][0][:transferOptions][0][:onlineOptions][0][:olResURI]
      assert_equal 'https://www.agency.gov/api/vegetables/', uri1

      # Second distribution: downloadURL with mediaType
      dist2 = hMetadata[:distributorInfo][1]
      uri2 = dist2[:distributor][0][:transferOptions][0][:onlineOptions][0][:olResURI]
      assert_equal 'https://www.agency.gov/vegetables/listofvegetables.csv', uri2
      media_type = dist2[:distributor][0][:transferOptions][0][:distributionFormats][0][:formatSpecification][:title]
      assert_equal 'text/csv', media_type
      title2 = dist2[:distributor][0][:transferOptions][0][:onlineOptions][0][:olResName]
      assert_equal 'listofvegetables.csv', title2

      assert hResponse[:readerExecutionPass]
   end

   def test_distribution_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('distribution')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hMetadata = @@intMetadataClass.newMetadata

      @@NameSpace.unpack(hIn, hMetadata, hResponse)

      assert_empty hMetadata[:distributorInfo]
   end

end
