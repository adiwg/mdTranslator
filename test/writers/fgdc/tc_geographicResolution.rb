# MdTranslator - minitest of
# writers / fgdc / class_geographicResolution

# History:
#  Stan Smith 2017-12-29 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcGeographicResolution < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # geographic resolution
   mdHash[:metadata][:resourceInfo][:spatialResolution] = []
   mdHash[:metadata][:resourceInfo][:spatialResolution] << TDClass.build_geographicResolution

   @@mdHash = mdHash

   def test_geographicResolution_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'geographicResolution', './metadata/spref/horizsys/geograph')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
