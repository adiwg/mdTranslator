# MdTranslator - minitest of
# writers / fgdc / class_lineage

# History:
#  Stan Smith 2017-12-18 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcLineage < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # add keywords
   hKeyword2 = TDClass.build_keywords('method keyword set one','method')
   TDClass.add_keyword(hKeyword2, 'one', '14rr-95sh74-ue17')
   TDClass.add_keyword(hKeyword2, 'two')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword2

   hKeyword3 = TDClass.build_keywords('method keyword set two','methodology')
   TDClass.add_keyword(hKeyword3, 'three')
   TDClass.add_keyword(hKeyword3, 'four')
   mdHash[:metadata][:resourceInfo][:keyword] << hKeyword3

   # build scope
   hTimePeriod = TDClass.build_timePeriod('tp1', nil, '2017-12-17', '2017-12-18')
   hScope = TDClass.scope
   hScope[:scopeExtent] << TDClass.extent
   hScope[:scopeExtent][0][:temporalExtent] << {}
   hScope[:scopeExtent][0][:temporalExtent][0][:timePeriod] = hTimePeriod

   # build lineage
   hLineage = TDClass.lineage
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   mdHash[:metadata][:dataQuality] << TDClass.dataQuality

   hCitation1 = TDClass.build_citation('method citation one', 'CID001')
   hCitation2 = TDClass.build_citation('method citation two', 'CID001')
   hLineage[:citation] = []
   hLineage[:citation] << hCitation1
   hLineage[:citation] << hCitation2

   hSource1 = TDClass.build_leSource('1', 'lineage source one', 1111, hScope)
   hSource2 = TDClass.build_leSource('2', 'lineage source two', 2222, hScope)
   hLineage[:source] << hSource1
   hLineage[:source] << hSource2

   hProcStep1 = TDClass.build_leProcessStep('a', 'lineage step one', hTimePeriod)
   hProcStep2 = TDClass.build_leProcessStep('b', 'lineage step two', hTimePeriod)
   hLineage[:processStep] << hProcStep1
   hLineage[:processStep] << hProcStep2

   # load lineage source
   hProcStep3 = TDClass.build_leProcessStep('c', 'source step one', hTimePeriod)
   hProcStep4 = TDClass.build_leProcessStep('d', 'source step two', hTimePeriod)
   hLineage[:source][0][:sourceProcessStep] << hProcStep3
   hLineage[:source][0][:sourceProcessStep] << hProcStep4

   # load lineage process step sources
   hSource3 = TDClass.build_leSource('1', 'process step source one', 1111, hScope)
   hSource4 = TDClass.build_leSource('3', 'process step source three', 3333, hScope)
   hLineage[:processStep][0][:stepSource] << hSource3
   hLineage[:processStep][0][:stepSource] << hSource4

   # load lineage process step product
   hSource5 = TDClass.build_leSource('2', 'process step product two', 2222, hScope)
   hSource6 = TDClass.build_leSource('4', 'process step product four', 4444, hScope)
   hLineage[:processStep][1][:stepProduct] << hSource5
   hLineage[:processStep][1][:stepProduct] << hSource6

   @@mdHash = mdHash

   def test_lineage_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'lineage', './metadata/dataqual/lineage')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_lineage_processStep

      # empty process steps
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0][:processStep] = []
      hIn[:metadata][:resourceLineage][0][:source][0][:sourceProcessStep] = []
      hIn[:metadata][:resourceLineage][0][:source][1][:sourceProcessStep] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: lineage source process steps are missing'

      # missing process steps
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceLineage][0].delete(:processStep)
      hIn[:metadata][:resourceLineage][0][:source][0].delete(:sourceProcessStep)
      hIn[:metadata][:resourceLineage][0][:source][1].delete(:sourceProcessStep)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: lineage source process steps are missing'

   end

end
