# MdTranslator - minitest of
# reader / dcat_us / module_identifier

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_identifier'

class TestReaderDcatUsIdentifier < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Identifier
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_identifier_doi_uri
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      # Online resource created
      assert_equal 1, hCitation[:onlineResources].length
      assert_equal 'https://doi.org/10.7927/H4PZ56R2', hCitation[:onlineResources][0][:olResURI]

      # Identifier with DOI namespace created because URI contains 'doi'
      assert_equal 1, hCitation[:identifiers].length
      assert_equal 'https://doi.org/10.7927/H4PZ56R2', hCitation[:identifiers][0][:identifier]
      assert_equal 'DOI', hCitation[:identifiers][0][:namespace]

      assert hResponse[:readerExecutionPass]
   end

   def test_identifier_non_doi
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn['identifier'] = 'https://catalog.data.gov/dataset/12345'
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_equal 1, hCitation[:onlineResources].length
      assert_empty hCitation[:identifiers]
   end

   def test_identifier_missing
      hIn       = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('identifier')
      hResponse = Marshal.load(Marshal.dump(@@responseObj))
      hCitation = @@intMetadataClass.newCitation

      @@NameSpace.unpack(hIn, hCitation, hResponse)

      assert_empty hCitation[:onlineResources]
      assert_empty hCitation[:identifiers]
   end

end
