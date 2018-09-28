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
   hSpaceRef[:referenceSystemParameterSet][:geodetic][:datumIdentifier] = TDClass.build_identifier('datum name')
   hSpaceRef[:referenceSystemParameterSet][:geodetic][:ellipsoidIdentifier] = TDClass.build_identifier('ellipsoid name')
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_geodetic_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'geodeticReference',
                                                  './metadata/spref/horizsys/geodetic')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_geodetic_datumIdentifier

      # datum identifier empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:datumIdentifier] = {}

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]

      # datum identifier missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:datumIdentifier)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]

   end

   def test_geodetic_ellipsoidIdentifier

      # ellipsoid identifier only
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:semiMajorAxis] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:axisUnits] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:denominatorOfFlatteningRatio] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]

   end

   def test_geodetic_ellipsoid

      # ellipsoid elements empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:ellipsoidIdentifier] = {}
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:semiMajorAxis] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:axisUnits] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic][:denominatorOfFlatteningRatio] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]

      # ellipsoid elements missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:ellipsoidIdentifier)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:semiMajorAxis)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:axisUnits)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:geodetic].delete(:denominatorOfFlatteningRatio)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]

   end

end
