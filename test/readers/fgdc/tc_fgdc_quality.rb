# MdTranslator - minitest of
# readers / fgdc / module_dataQuality

# History:
#   Stan Smith 2017-08-31 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcQuality < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('dataQuality.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::DataQuality

   def test_quality_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      intObj = TestReaderFGDCParent.set_intObj
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      xIn = @@xDoc.xpath('./metadata/dataqual')

      hDataQuality = @@NameSpace.unpack(xIn, intObj[:metadata], intObj[:metadata][:dataQuality], hResponse)

      refute_nil hDataQuality
      assert_equal 1, intObj[:metadata][:lineageInfo].length

      # require 'pry'; binding.pry

      horizpa = hDataQuality[:report].find do |h| 
         h[:type] == 'DQ_AbsoluteExternalPositionalAccuracy' && 
         h.dig(:descriptiveResult, 0, :name) == 'Horizontal Positional Accuracy Report'
      end
      assert_equal 'GPS Unit', horizpa.dig(:descriptiveResult, 0, :statement)
      assert_equal 'Horizontal Positional Accuracy Explanation', horizpa.dig(:descriptiveResult, 1, :name)
      assert_equal 'Instrument parameters', horizpa.dig(:descriptiveResult, 1, :statement)

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: lineage procedure date is missing'

   end

end
