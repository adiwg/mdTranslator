# MdTranslator - minitest of
# writers / fgdc / class_quality

# History:
#  Stan Smith 2018-03-23 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcQuality < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # build lineage
   hLineage = TDClass.lineage
   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_quality_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'quality', './metadata/dataqual')
      assert_equal hReturn[0], hReturn[1]
      refute hReturn[2]

   end

end
