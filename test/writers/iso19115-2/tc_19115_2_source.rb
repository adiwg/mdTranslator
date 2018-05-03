# MdTranslator - minitest of
# writers / iso19115_2 / class_source

# History:
#  Stan Smith 2018-04-30 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-10 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Source < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage

   # build sources
   hSource1 = TDClass.build_source('SRC001','source one')
   hSource1[:sourceCitation] = {}
   hLineage[:source] << hSource1

   hSource2 = TDClass.build_source('SRC002','source two')
   hSource2[:sourceCitation] = TDClass.citation_title
   hSource2[:metadataCitation] << TDClass.build_citation('source metadata one title')
   hSource2[:metadataCitation] << TDClass.build_citation('source metadata two title')
   hSource2[:spatialResolution] = { scaleFactor: 25000 }
   hSource2[:referenceSystem] = TDClass.spatialReferenceSystem
   hSource2[:sourceProcessStep] << TDClass.build_processStep('SPS001')
   hSource2[:sourceProcessStep] << TDClass.build_processStep('SPS002')
   hSource2[:scope] = TDClass.scope
   hLineage[:source] << hSource2

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_source_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_source',
                                                '//gmd:LI_Source[1]',
                                                '//gmd:LI_Source', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                      'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is lineage source citation'
   end

   def test_source_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_source',
                                                '//gmd:LI_Source[2]',
                                                '//gmd:LI_Source', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_equal 1, hReturn[3].length
      assert_includes hReturn[3],
                     'WARNING: ISO-19115-2 writer: citation dates are missing: CONTEXT is lineage source citation'

   end

end
