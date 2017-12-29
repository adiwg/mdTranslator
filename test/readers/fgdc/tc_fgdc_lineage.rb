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

      TestReaderFGDCParent.set_intObj()
      TestReaderFGDCParent.set_xDoc(@@xDoc)
      hIntObj = TestReaderFGDCParent.get_intObj
      xIn = @@xDoc.xpath('./metadata/dataqual/lineage')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hLineage = @@NameSpace.unpack(xIn, hResponse)

      # keywords
      aKeywords = hIntObj[:metadata][:resourceInfo][:keywords]
      assert_equal 3, aKeywords.length
      hKeyword = aKeywords[0]
      assert_equal 'method', hKeyword[:keywordType]
      assert_equal 2, hKeyword[:keywords].length
      assert_equal 'method keyword thesaurus one', hKeyword[:thesaurus][:title]
      assert_equal 'one', hKeyword[:keywords][0][:keyword]
      assert_nil hKeyword[:keywords][0][:keywordId]
      assert_equal 'two', hKeyword[:keywords][1][:keyword]

      # lineage
      refute_nil hLineage
      assert_equal 'method description one; method description two', hLineage[:statement]
      assert_equal 3, hLineage[:lineageCitation].length
      assert_equal 2, hLineage[:dataSources].length
      assert_equal 2, hLineage[:processSteps].length

      # citation
      hCitation = hLineage[:lineageCitation][0]
      assert_equal 'method citation one', hCitation[:title]

      # dataSource
      hSource = hLineage[:dataSources][0]
      assert_equal 'source id', hSource[:sourceId]
      assert_equal 'my source 1 contribution', hSource[:description]
      refute_empty hSource[:spatialResolution]
      assert_equal 25000, hSource[:spatialResolution][:scaleFactor]
      refute_empty hSource[:scope]

      hScope = hSource[:scope]
      assert_equal 'dataset', hScope[:scopeCode]
      assert_empty hScope[:scopeDescriptions]
      assert_equal 1, hScope[:extents].length

      hExtent = hScope[:extents][0]
      assert_nil hExtent[:description]
      assert_empty hExtent[:geographicExtents]
      assert_equal 1, hExtent[:temporalExtents].length
      assert_empty hExtent[:verticalExtents]

      hTempExtent = hExtent[:temporalExtents][0]
      assert_empty hTempExtent[:timeInstant]
      refute_empty hTempExtent[:timePeriod]

      hTimePeriod = hTempExtent[:timePeriod]
      assert_nil hTimePeriod[:timeId]
      assert_equal 'publication', hTimePeriod[:description]
      assert_empty hTimePeriod[:startDateTime]
      refute_empty hTimePeriod[:endDateTime]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
