# MdTranslator - minitest of
# readers / fgdc / module_citation

# History:
#   Stan Smith 2017-08-18 original script

require 'date'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_citation'
require_relative 'fgdc_test_parent'

class TestReaderFgdcCitation < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('citation.xml')
   @@xCitation = @@xDoc.xpath('./metadata/citation')

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Citation

   def test_citation_complete

      # build mdTranslator internal object
      intMetadataClass = InternalMetadata.new
      intObj = intMetadataClass.newBase
      hMetadata = intMetadataClass.newMetadata
      hResourceInfo = intMetadataClass.newResourceInfo
      hMetadata[:resourceInfo] = hResourceInfo
      intObj[:metadata] = hMetadata
      TestReaderFGDCParent.set_intObj(intObj)

      # make test XML available to other modules
      TestReaderFGDCParent.set_xDoc(@@xDoc)

      hCitation = @@NameSpace.unpack(@@xCitation, @@hResponseObj)

      refute_empty hCitation
      assert_equal 'My Citation Title', hCitation[:title]
      assert_empty hCitation[:alternateTitles]
      assert_equal 1, hCitation[:dates].length
      assert_equal '2.1', hCitation[:edition]
      assert_equal 2, hCitation[:responsibleParties].length
      assert_equal 1, hCitation[:presentationForms].length
      assert_empty hCitation[:identifiers]
      refute_empty hCitation[:series]
      assert_equal 1, hCitation[:otherDetails].length
      assert_equal 2, hCitation[:onlineResources].length
      assert_empty hCitation[:browseGraphics]

      hDate = hCitation[:dates][0]
      assert_equal DateTime.strptime('2017-06-15T13:08:00z'), hDate[:date]

      hResParty = hCitation[:responsibleParties][0]
      assert_equal 'originator', hResParty[:roleName]
      assert_equal 2, hResParty[:parties].length
      assert_empty hResParty[:roleExtents]

      hForm = hCitation[:presentationForms][0]
      assert_equal 'tableDigital', hForm

      hSeries = hCitation[:series]
      assert_equal 'My Series Name', hSeries[:seriesName]
      assert_equal '1', hSeries[:seriesIssue]
      assert_nil hSeries[:issuePage]

      hDetail = hCitation[:otherDetails][0]
      assert_equal 'My other citation details', hDetail

      hResource = hCitation[:onlineResources][0]
      assert_equal 'https://online.link/1', hResource[:olResURI]
      assert_equal 'Link to the resource described in this citation', hResource[:olResDesc]

      hPostObj = TestReaderFGDCParent.get_intObj

      aContacts = hPostObj[:contacts]
      assert_equal 5, aContacts.length
      refute_nil aContacts[0][:contactId]
      refute aContacts[0][:isOrganization]
      assert_equal 'First Name', aContacts[0][:name]

      aAssRes = hPostObj[:metadata][:associatedResources]
      assert_equal 1, aAssRes.length
      assert_equal 'largerWorkCitation', aAssRes[0][:associationType]
      refute_empty aAssRes[0][:resourceCitation]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
