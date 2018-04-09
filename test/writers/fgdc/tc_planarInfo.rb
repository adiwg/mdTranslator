# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-12 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapCoordinateInfo < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # expect file
   @@path = './metadata/spref/horizsys/planar/planci'
   xFile = TestWriterFGDCParent.get_xml('mapPlanarInfo')
   @@xaExpect = xFile.xpath(@@path)

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'planar coordinate encoding method'
   mdHash[:metadata][:resourceInfo][:spatialResolution] = []

   @@mdHash = mdHash

   def test_coordinate_resolution

      expect = @@xaExpect[0].to_s.squeeze(' ')

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hSpaceRes = TDClass.build_coordinateResolution
      hIn[:metadata][:resourceInfo][:spatialResolution] << hSpaceRes

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

   end

   def test_bearingDistance_resolution

      expect = @@xaExpect[1].to_s.squeeze(' ')

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialResolution] = []
      hSpaceRes = TDClass.build_bearingResolution
      hIn[:metadata][:resourceInfo][:spatialResolution] << hSpaceRes

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

   end

   # encoding method tests
   def test_planar_encodingMethod

      # empty encoding method
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = []
      hSpaceRes = TDClass.build_bearingResolution
      hIn[:metadata][:resourceInfo][:spatialResolution] << hSpaceRes

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: planar coordinate information encoding method is missing'

      # missing encoding method
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo].delete(:spatialRepresentationType)
      hSpaceRes = TDClass.build_bearingResolution
      hIn[:metadata][:resourceInfo][:spatialResolution] << hSpaceRes

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: planar coordinate information encoding method is missing'

   end

end
