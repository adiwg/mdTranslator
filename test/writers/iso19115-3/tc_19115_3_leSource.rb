# MdTranslator - minitest of
# writers / iso19115_3 / class_leSource

# History:
#  Stan Smith 2019-09-27 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151leSource < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage

   # build sources
   hLineage[:source] << TDClass.build_leSource_full
   hLineage[:source] << TDClass.build_leSource('SRC002', 'source two')

   hLineage[:source][1].delete(:sourceCitation)
   hLineage[:source][1].delete(:metadataCitation)
   hLineage[:source][1].delete(:spatialResolution)
   hLineage[:source][1].delete(:referenceSystem)
   hLineage[:source][1].delete(:sourceProcessStep)
   hLineage[:source][1].delete(:scope)
   hLineage[:source][1].delete(:resolution)

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_source_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_leSource',
                                                '//mrl:LE_Source[1]',
                                                '//mrl:LE_Source', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_source_minimal

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_leSource',
                                                '//mrl:LE_Source[2]',
                                                '//mrl:LE_Source', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]
   end

end
