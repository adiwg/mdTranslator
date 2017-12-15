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

      xIn = @@xDoc.xpath('./metadata/dataqual/lineage')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hLineage = @@NameSpace.unpack(xIn, hResponse)

      refute_nil hLineage
      assert_equal 2, hLineage[:dataSources].length
      assert_equal 2, hLineage[:processSteps].length

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
