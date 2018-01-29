# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2017-12-29 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSpatialReference < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # geographic resolution
   mdHash[:metadata][:resourceInfo][:spatialResolution] = []
   mdHash[:metadata][:resourceInfo][:spatialResolution] << TDClass.build_geographicResolution

   @@mdHash = mdHash

   def test_spatialResolution_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'spatialResolution', './metadata/spref/horizsys/geograph')
      assert_equal hReturn[0], hReturn[1]

   end

end
