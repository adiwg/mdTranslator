# MdTranslator - minitest of
# readers / fgdc / module_quality

# History:
#   Stan Smith 2017-08-31 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcQuality < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('lineage.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Quality

   def test_quality_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      intObj = TestReaderFGDCParent.set_intObj
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      xIn = @@xDoc.xpath('./metadata/dataqual')

      hMetadata = @@NameSpace.unpack(xIn, intObj[:metadata], hResponse)

      refute_nil hMetadata
      assert_equal 1, hMetadata[:lineageInfo].length

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC contact address is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC contact voice phone is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC lineage procedure date is missing'

   end

end
