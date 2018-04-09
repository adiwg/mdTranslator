# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-16 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcGeodeticSystem < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   mdHash = TDClass.base
   hSpaceRef = TDClass.spatialReferenceSystem
   TDClass.add_geodetic(hSpaceRef)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_distribution_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'geodeticReference',
                                                  './metadata/spref/horizsys/geodetic')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_map_geodeticReference_semiMajorAxis

      # semi-major axis empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:semiMajorAxis] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: geodetic coordinate system semi-major axis is missing'

      # semi-major axis missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:semiMajorAxis)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: geodetic coordinate system semi-major axis is missing'

   end

   def test_map_geodeticReference_denominator

      # denominator of flattening ration empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:denominatorOfFlatteningRatio] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: geodetic coordinate system denominator of flattening ratio is missing'

      # denominator of flattening ration missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:denominatorOfFlatteningRatio)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: geodetic coordinate system denominator of flattening ratio is missing'

   end

end
