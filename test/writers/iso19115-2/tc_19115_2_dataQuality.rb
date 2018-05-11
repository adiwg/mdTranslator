# MdTranslator - minitest of
# writers / iso19115_2 / class_dataQuality

# History:
#  Stan Smith 2018-04-19 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-12-22 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152DataQuality < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_dataQuality_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dataQuality',
                                                '//gmd:dataQualityInfo[1]',
                                                '//gmd:dataQualityInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_dataQuality_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hLineage = hIn[:metadata][:resourceLineage][0]
      # add citation
      hLineage[:citation] << TDClass.citation

      # add processStep
      hProcStep1 = TDClass.build_processStep('step one', 'lineage step one')
      hProcStep2 = TDClass.build_processStep('step two', 'lineage step two')
      hLineage[:processStep] << hProcStep1
      hLineage[:processStep] << hProcStep2

      # add source
      hSource1 = TDClass.build_source('source one', 'lineage source one')
      hSource2 = TDClass.build_source('source two', 'lineage source two')
      hLineage[:source] << hSource1
      hLineage[:source] << hSource2

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_dataQuality',
                                                '//gmd:dataQualityInfo[2]',
                                                '//gmd:dataQualityInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
