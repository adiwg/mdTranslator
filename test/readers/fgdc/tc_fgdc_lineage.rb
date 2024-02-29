# MdTranslator - minitest of
# readers / fgdc / module_lineage

# History:
#   Stan Smith 2017-08-31 original script

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
      assert_equal 'methodology', hKeyword[:keywordType]
      assert_equal 2, hKeyword[:keywords].length
      assert_equal 'method keyword thesaurus one', hKeyword[:thesaurus][:title]
      assert_equal 'one', hKeyword[:keywords][0][:keyword]
      assert_nil hKeyword[:keywords][0][:keywordId]
      assert_equal 'two', hKeyword[:keywords][1][:keyword]

      # lineage
      refute_nil hLineage
      # statement to processStep description, change 
      assert_nil hLineage[:statement]   
      refute_empty hLineage[:processSteps]
      
      # 4 total, 2 from methodology and 2 from process step
      assert_equal 4, hLineage[:processSteps].length

      # 2 tests for descriptions in methods
      assert_equal 'method description one', hLineage[:processSteps][0][:description]
      assert_equal 'method description two', hLineage[:processSteps][1][:description]

      # expected 2 citations in the first process step
      assert_equal 2, hLineage[:processSteps][0][:references].length

      # expected 1 citation in the second process step
      assert_equal 1, hLineage[:processSteps][1][:references].length

      
      # process step descriptions
      assert_equal 'my proc step 1 description', hLineage[:processSteps][2][:description]
      assert_equal 'my proc step 2 description', hLineage[:processSteps][3][:description]
      
      # citations within the methodologies
      hCitation1 = hLineage[:processSteps][0][:references][0]
      refute_nil hCitation1
      assert_equal 'method citation one', hCitation1[:title]
      
      hCitation2 = hLineage[:processSteps][0][:references][1]
      refute_nil hCitation2
      assert_equal 'method citation two', hCitation2[:title]
      
      hCitation3 = hLineage[:processSteps][1][:references][0]
      refute_nil hCitation3
      assert_equal 1, hLineage[:processSteps][1][:references].length
      assert_equal 'method citation three', hCitation3[:title]
      
      # lineageCitation
      assert_equal 0, hLineage[:lineageCitation].length
      
      # dataSource
      assert_equal 2, hLineage[:dataSources].length
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
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: contact address is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: contact voice phone is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: lineage procedure date is missing'

   end

end
