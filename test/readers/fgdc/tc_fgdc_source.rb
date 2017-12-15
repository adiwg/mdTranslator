# MdTranslator - minitest of
# readers / fgdc / module_source

# History:
#   Stan Smith 2017-08-29 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcSource < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('lineage.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Source

   def test_source_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/dataqual/lineage/srcinfo').first
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hSource = @@NameSpace.unpack(xIn, hResponse)

      refute_nil hSource
      assert_equal 'my source 1 contribution', hSource[:description]
      refute_empty hSource[:sourceCitation]
      refute_empty hSource[:scope]

      hCitation = hSource[:sourceCitation]
      assert_equal 'my source 1 citation title', hCitation[:title]
      assert_equal 1, hCitation[:alternateTitles].length
      assert_equal 'ADIwg', hCitation[:alternateTitles][0]
      assert_equal 1, hCitation[:dates].length
      assert_equal 1, hCitation[:responsibleParties].length
      assert_equal 1, hCitation[:presentationForms].length
      assert_equal 'my source 1 geo form', hCitation[:presentationForms][0]

      hResolution = hSource[:spatialResolution]
      assert_equal 25000, hResolution[:scaleFactor]
      assert_empty hResolution[:measure]
      assert_nil hResolution[:levelOfDetail]

      hResponsibility = hCitation[:responsibleParties][0]
      assert_equal 'originator', hResponsibility[:roleName]
      assert_empty hResponsibility[:roleExtents]
      assert_equal 1, hResponsibility[:parties].length

      hScope = hSource[:scope]
      assert_equal 'dataset', hScope[:scopeCode]
      assert_empty hScope[:scopeDescriptions]
      assert_equal 1, hScope[:extents].length

      hExtent = hScope[:extents][0]
      assert_nil hExtent[:description]
      assert_empty hExtent[:geographicExtents]
      assert_equal 1, hExtent[:temporalExtents].length
      assert_empty hExtent[:verticalExtents]

      hTemporal = hExtent[:temporalExtents][0]
      assert_empty hTemporal[:timeInstant]
      refute_empty hTemporal[:timePeriod]

      hTimePeriod = hTemporal[:timePeriod]
      assert_equal 'publication', hTimePeriod[:description]
      assert_empty hTimePeriod[:startDateTime]
      refute_empty hTimePeriod[:endDateTime]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
