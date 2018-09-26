# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-17 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcVerticalDatum < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # elevation
   hSpaceRef = TDClass.spatialReferenceSystem
   TDClass.add_verticalDatum(hSpaceRef, isDepth = false)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   # depth
   hSpaceRef = TDClass.spatialReferenceSystem
   TDClass.add_verticalDatum(hSpaceRef, isDepth = true)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

   @@mdHash = mdHash

   def test_verticalDatum_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'verticalDatum', './metadata/spref/vertdef')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_verticalDatum_elements

      # altitude elements empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:verticalDatum][:encodingMethod] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:verticalDatum][:verticalResolution] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:verticalDatum][:unitOfMeasure] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical altitude resolution is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical altitude units of measure is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical altitude encoding method is missing'

      # altitude elements missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:verticalDatum].delete(:encodingMethod)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:verticalDatum].delete(:verticalResolution)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][0][:referenceSystemParameterSet][:verticalDatum].delete(:unitOfMeasure)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical altitude resolution is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical altitude units of measure is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical altitude encoding method is missing'

      # depth elements empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet][:verticalDatum][:encodingMethod] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet][:verticalDatum][:verticalResolution] = ''
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet][:verticalDatum][:unitOfMeasure] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical depth resolution is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical depth units of measure is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical depth encoding method is missing'

      # depth elements missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet][:verticalDatum].delete(:encodingMethod)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet][:verticalDatum].delete(:verticalResolution)
      hIn[:metadata][:resourceInfo][:spatialReferenceSystem][1][:referenceSystemParameterSet][:verticalDatum].delete(:unitOfMeasure)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical depth resolution is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical depth units of measure is missing'
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: vertical depth encoding method is missing'

   end

end
