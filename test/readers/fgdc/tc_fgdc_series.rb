# MdTranslator - minitest of
# readers / fgdc / module_series

# History:
#   Stan Smith 2017-08-14 original script

require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcSeries < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('series.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Series

   def test_series_complete

      xIn = @@xDoc.xpath('./serinfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hSeries = @@NameSpace.unpack(xIn, hResponse)

      refute_empty hSeries
      assert_equal 'Series Name', hSeries[:seriesName]
      assert_equal 'Spring 2017', hSeries[:seriesIssue]
      assert_nil hSeries[:issuePage]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
