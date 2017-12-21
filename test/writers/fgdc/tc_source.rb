# MdTranslator - minitest of
# writers / fgdc / class_source

# History:
#  Stan Smith 2017-12-20 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSource < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # add keywords
   hKeyword2 = TDClass.build_keywords('method keyword set one','method')
   TDClass.add_keyword(hKeyword2, 'one', '14rr-95sh74-ue17')
   TDClass.add_keyword(hKeyword2, 'two')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword2

   hKeyword3 = TDClass.build_keywords('method keyword set two','method')
   TDClass.add_keyword(hKeyword3, 'three')
   TDClass.add_keyword(hKeyword3, 'four')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword3

   # build time period(s)
   hTime1 = TDClass.build_timePeriod('tp1', nil, '2017-12-17', '2017-12-18')
   hTime2 = TDClass.build_timePeriod('tp2', nil, '2017-12-17', '2017-12-18')
   hTime3 = TDClass.build_timePeriod('tp3', nil, '2017-12-17', '2017-12-18')
   hTime4 = TDClass.build_timePeriod('tp4', nil, '2017-12-17', '2017-12-18')

   # build scope(s)
   hScope = TDClass.scope
   hScope[:scopeExtent] << TDClass.extent
   hScope[:scopeExtent][0][:temporalExtent] << {}
   hScope1 = Marshal::load(Marshal.dump(hScope))
   hScope1[:scopeExtent][0][:temporalExtent][0][:timePeriod] = hTime1
   hScope2 = Marshal::load(Marshal.dump(hScope))
   hScope2[:scopeExtent][0][:temporalExtent][0][:timePeriod] = hTime2
   hScope3 = Marshal::load(Marshal.dump(hScope))
   hScope3[:scopeExtent][0][:temporalExtent][0][:timePeriod] = hTime3
   hScope4 = Marshal::load(Marshal.dump(hScope))
   hScope4[:scopeExtent][0][:temporalExtent][0][:timePeriod] = hTime4

   # build lineage
   hLineage = TDClass.lineage
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   hCitation1 = TDClass.build_citation('method citation one', 'CID001')
   hCitation2 = TDClass.build_citation('method citation two', 'CID001')
   hLineage[:citation] << hCitation1
   hLineage[:citation] << hCitation2

   hSource1 = TDClass.build_source('1', 'lineage source one', 1111, hScope1)
   hSource2 = TDClass.build_source('2', 'lineage source two', 2222, hScope2)
   hLineage[:source] << hSource1
   hLineage[:source] << hSource2

   hProcStep1 = TDClass.build_processStep('a', 'lineage step one', hTime1)
   hProcStep2 = TDClass.build_processStep('b', 'lineage step two', hTime2)
   hLineage[:processStep] << hProcStep1
   hLineage[:processStep] << hProcStep2

   # load lineage source
   hProcStep3 = TDClass.build_processStep('c', 'source step one', hTime3)
   hProcStep4 = TDClass.build_processStep('d', 'source step two', hTime4)
   hLineage[:source][0][:sourceProcessStep] << hProcStep3
   hLineage[:source][0][:sourceProcessStep] << hProcStep4

   # load lineage process step sources
   hSource3 = TDClass.build_source('1', 'process step source one', 1111, hScope1)
   hSource4 = TDClass.build_source('3', 'process step source three', 3333, hScope3)
   hLineage[:processStep][0][:stepSource] << hSource3
   hLineage[:processStep][0][:stepSource] << hSource4

   # load lineage process step product
   hSource5 = TDClass.build_source('2', 'process step product two', 2222, hScope2)
   hSource6 = TDClass.build_source('4', 'process step product four', 4444, hScope4)
   hLineage[:processStep][1][:stepProduct] << hSource5
   hLineage[:processStep][1][:stepProduct] << hSource6

   @@mdHash = mdHash

   def test_source_missing_id

      # empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:source][0][:sourceId] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Lineage Source is missing source abbreviation (source id)'

      # missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:source][0].delete(:sourceId)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Lineage Source is missing source abbreviation (source id)'

   end

   def test_source_missing_citation

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:source][0].delete(:sourceCitation)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Lineage Source is missing citation'

   end

   def test_source_missing_timePeriod

      # remove timePeriod at scope level
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:source][0].delete(:scope)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Lineage Source is missing time period'

   end

end
