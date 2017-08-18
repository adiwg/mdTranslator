# MdTranslator - minitest of
# readers / fgdc / module_series

# History:
#   Stan Smith 2017-09-14 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcSeries < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('series.xml')

   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Series

   def test_series_complete

      xIn = @@xDoc.xpath('./serinfo')
      hSeries = @@NameSpace.unpack(xIn, @@hResponseObj)

      refute_empty hSeries
      assert_equal 'Series Name', hSeries[:seriesName]
      assert_equal 'Spring 2017', hSeries[:seriesIssue]
      assert_nil hSeries[:issuePage]
      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
