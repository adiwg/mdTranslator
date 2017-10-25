# MdTranslator - minitest of
# readers / fgdc / module_distribution

# History:
#   Stan Smith 2017-09-10 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcDistribution < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('distribution.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Distribution

   def test_distribution_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/distinfo[1]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDistribution = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hDistribution
      text = 'distribution resource description\n\n Technical Prerequisites: distribution technical prerequisite'
      assert_equal text, hDistribution[:description]
      assert_equal 1, hDistribution[:distributor].length

      hDistributor = hDistribution[:distributor][0]
      refute_empty hDistributor[:contact]
      assert_equal 3, hDistributor[:orderProcess].length
      assert_equal 3, hDistributor[:transferOptions].length

      assert_equal 1, hResourceInfo[:constraints].length

      hConstraint = hResourceInfo[:constraints][0]
      assert_equal 'legal', hConstraint[:type]
      refute_empty hConstraint[:legalConstraint]

      hLegalCon = hConstraint[:legalConstraint]
      assert_empty hLegalCon[:accessCodes]
      assert_empty hLegalCon[:useCodes]
      assert_equal 1,hLegalCon[:otherCons].length
      assert_equal 'distributor liability statement 1', hLegalCon[:otherCons][0]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
