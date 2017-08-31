# MdTranslator - minitest of
# readers / fgdc / module_lineage

# History:
#   Stan Smith 2017-08-31 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcLineage < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('lineage.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Lineage

   def test_lineage_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/dataqual/lineage')

      hLineage = @@NameSpace.unpack(xIn, hResourceInfo,@@hResponseObj)

      refute_nil hLineage
      assert_equal 2, hLineage[:dataSources].length
      assert_equal 2, hLineage[:processSteps].length

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
