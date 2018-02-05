# MdTranslator - minitest of
# readers / fgdc / module_metadataInfo

# History:
#   Stan Smith 2017-09-10 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcMetadataInfo < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('metadataInfo.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::MetadataInformation

   def test_metadataInfo_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/metainfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hMetadataInfo = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hMetadataInfo
      assert_empty hMetadataInfo[:metadataIdentifier]
      assert_empty hMetadataInfo[:parentMetadata]
      assert_empty hMetadataInfo[:otherMetadataLocales]
      assert_equal 1, hMetadataInfo[:metadataContacts].length
      assert_equal 'pointOfContact', hMetadataInfo[:metadataContacts][0][:roleName]
      assert_equal 3, hMetadataInfo[:metadataDates].length
      assert_empty hMetadataInfo[:metadataLinkages]
      assert_empty hMetadataInfo[:metadataMaintenance]
      assert_empty hMetadataInfo[:alternateMetadataReferences]
      assert_nil hMetadataInfo[:metadataStatus]
      assert_empty hMetadataInfo[:extensions]

      hDate0 = hMetadataInfo[:metadataDates][0]
      assert_kind_of DateTime, hDate0[:date]
      assert_equal 'YMDhmsZ', hDate0[:dateResolution]
      assert_equal 'creation', hDate0[:dateType]

      hDate1 = hMetadataInfo[:metadataDates][1]
      assert_equal 'review', hDate1[:dateType]

      hDate2 = hMetadataInfo[:metadataDates][2]
      assert_equal 'nextReview', hDate2[:dateType]

      assert_equal 2, hMetadataInfo[:metadataConstraints].length
      hConstraint0 = hMetadataInfo[:metadataConstraints][0]
      assert_equal 'legal', hConstraint0[:type]
      refute_empty hConstraint0[:legalConstraint]
      assert_empty hConstraint0[:securityConstraint]

      hLegal = hConstraint0[:legalConstraint]
      assert_equal 1, hLegal[:accessCodes].length
      assert_equal 'metadata access restriction', hLegal[:accessCodes][0]
      assert_equal 1, hLegal[:useCodes].length
      assert_equal 'metadata use restriction', hLegal[:useCodes][0]
      assert_empty hLegal[:otherCons]

      hConstraint1 = hMetadataInfo[:metadataConstraints][1]
      assert_equal 'security', hConstraint1[:type]
      assert_empty hConstraint1[:legalConstraint]
      refute_empty hConstraint1[:securityConstraint]

      hSecurity = hConstraint1[:securityConstraint]
      assert_equal 'security classification', hSecurity[:classCode]
      assert_nil hSecurity[:userNote]
      assert_equal 'security classification system', hSecurity[:classSystem]
      assert_equal 'handling instructions', hSecurity[:handling]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
