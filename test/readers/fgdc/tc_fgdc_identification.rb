# MdTranslator - minitest of
# readers / fgdc / module_identification

# History:
#   Stan Smith 2017-08-26 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcIdentification < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('identification.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Identification

   def test_identification_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      intObj = TestReaderFGDCParent.get_intObj

      xIn = @@xDoc.xpath('./metadata/idinfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hIntObj = @@NameSpace.unpack(xIn, intObj, hResponse)

      refute_empty hIntObj
      assert_empty hIntObj[:schema]
      assert_equal 8, hIntObj[:contacts].length
      refute_empty hIntObj[:metadata]
      assert_empty hIntObj[:dataDictionaries]
      assert_empty hIntObj[:metadataRepositories]

      hMetadata = hIntObj[:metadata]
      refute_empty hMetadata[:resourceInfo]
      assert_equal 2, hMetadata[:associatedResources].length

      hResourceInfo = hMetadata[:resourceInfo]
      assert_empty hResourceInfo[:resourceTypes]
      refute_empty hResourceInfo[:citation]
      assert_equal 'my abstract', hResourceInfo[:abstract]
      assert_equal 'my purpose', hResourceInfo[:purpose]
      assert_equal 1, hResourceInfo[:credits].length
      assert_equal 'my dataset credits', hResourceInfo[:credits][0]
      refute_empty hResourceInfo[:timePeriod]
      assert_equal 1, hResourceInfo[:status].length
      assert_equal 'complete', hResourceInfo[:status][0]
      assert_equal 1, hResourceInfo[:pointOfContacts].length
      assert_equal 1, hResourceInfo[:extents].length
      assert_equal 1, hResourceInfo[:graphicOverviews].length
      assert_equal 5, hResourceInfo[:keywords].length
      assert_equal 2, hResourceInfo[:constraints].length
      assert_equal 'my native dataset environment', hResourceInfo[:environmentDescription]
      assert_equal 'my supplemental information', hResourceInfo[:supplementalInfo]
      assert_equal 1, hResourceInfo[:resourceMaintenance].length
      assert_equal 'None planned', hResourceInfo[:resourceMaintenance][0][:frequency]

      hExtent = hResourceInfo[:extents][0]
      assert_equal 'FGDC spatial domain', hExtent[:description]
      assert_equal 1, hExtent[:geographicExtents].length
      assert_empty hExtent[:temporalExtents]
      assert_empty hExtent[:verticalExtents]

      hGraphic = hResourceInfo[:graphicOverviews][0]
      assert_equal 'my browse file name', hGraphic[:graphicName]
      assert_equal 'my browse file description', hGraphic[:graphicDescription]
      assert_equal 'my browse file type', hGraphic[:graphicType]
      assert_empty hGraphic[:graphicConstraints]
      assert_empty hGraphic[:graphicURI]

      hConstraint = hResourceInfo[:constraints][0]
      assert_equal 'legal', hConstraint[:type]
      assert_empty hConstraint[:useLimitation]
      assert_empty hConstraint[:scope]
      assert_empty hConstraint[:reference]
      assert_empty hConstraint[:releasability]
      assert_empty hConstraint[:responsibleParty]
      refute_empty hConstraint[:legalConstraint]
      assert_empty hConstraint[:securityConstraint]

      hLegal = hConstraint[:legalConstraint]
      assert_equal 'my access constraint', hLegal[:accessCodes][0]
      assert_equal 'my use constraint', hLegal[:useCodes][0]
      assert_equal 2, hLegal[:otherCons].length
      assert_equal 'my access constraint', hLegal[:otherCons][0]
      assert_equal 'my use constraint', hLegal[:otherCons][1]

      hConstraint = hResourceInfo[:constraints][1]
      assert_equal 'security', hConstraint[:type]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
