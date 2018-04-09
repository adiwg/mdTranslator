# MdTranslator - minitest of
# writers / fgdc / class_spatialDomain

# History:
#  Stan Smith 2017-11-25 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSpatialDomain < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGeoExtent = mdHash[:metadata][:resourceInfo][:extent][0][:geographicExtent][0]
   TDClass.add_altitudeBB(hGeoExtent[:boundingBox])

   hGeoExtent[:geographicElement] = []
   TDClass.add_featureCollection(hGeoExtent[:geographicElement])
   hGeoExtent[:geographicElement][0][:features] << TDClass.build_feature('id001', 'polygon', 'FGDC bounding polygon')

   @@mdHash = mdHash

   def test_spatialDomain_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'spatialDomain', './metadata/idinfo/spdom')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_spatialDomain_geographicDescription

      # geographic description empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:description] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: spatial domain geographic description is missing'

      # geographic description missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0].delete(:description)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: spatial domain geographic description is missing'

   end

   def test_spatialDomain_boundingBox

      # bounding box empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:boundingBox] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: spatial domain bounding box is missing'

      # bounding box missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0].delete(:boundingBox)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: spatial domain bounding box is missing'

   end

   def test_spatialDomain_altitudeBounding

      # altitude bounding box empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:boundingBox][:minimumAltitude] = ''
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:boundingBox][:maximumAltitude] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: altitude bounding box minimum altitude is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: altitude bounding box maximum altitude is missing'

      # altitude bounding box missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:boundingBox].delete(:minimumAltitude)
      hIn[:metadata][:resourceInfo][:extent][0][:geographicExtent][0][:boundingBox].delete(:maximumAltitude)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: altitude bounding box minimum altitude is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: altitude bounding box maximum altitude is missing'

   end

end
