# MdTranslator - minitest of
# writers / iso19115_2 / class_nominalResolution

# History:
#  Stan Smith 2019-09-26 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152NominalResolution < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # instance classes needed in script
   mdHash = TDClass.base

   hSource = TDClass.source
   hSource.delete(:sourceCitation)
   hSource.delete(:metadataCitation)
   hSource.delete(:spatialResolution)
   hSource.delete(:referenceSystem)
   hSource.delete(:sourceProcessStep)
   hSource.delete(:scope)
   hSource.delete(:processedLevel)

   hLineage = TDClass.lineage
   hLineage[:source] << hSource
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_nominalResolution_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_nominalResolution',
                                                '//gmi:resolution[1]',
                                                '//gmi:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_nominalResolution_ground

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hResolution = hIn[:metadata][:resourceLineage][0][:source][0][:resolution]
      hResolution[:groundResolution] = {
         type: 'distance',
         value: 9.999,
         unitOfMeasure: 'units'
      }
      hResolution.delete(:scanningResolution)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_nominalResolution',
                                                '//gmi:resolution[2]',
                                                '//gmi:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
