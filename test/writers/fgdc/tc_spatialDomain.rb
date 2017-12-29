# MdTranslator - minitest of
# writers / fgdc / class_spatialDomain

# History:
#  Stan Smith 2017-11-25 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSpatialDomain < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
   TDClass.add_altitudeBB(hGeoExtent[:boundingBox])

   hGeoExtent[:geographicElement] = []
   TDClass.add_featureCollection(hGeoExtent[:geographicElement])
   hGeoExtent[:geographicElement][0][:features] << TDClass.build_feature('id001', 'polygon', 'FGDC bounding polygon')

   @@mdHash = mdHash

   def test_spatialDomain_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'spatialDomain', './metadata/idinfo/spdom')
      assert_equal hReturn[0], hReturn[1]

   end

end
