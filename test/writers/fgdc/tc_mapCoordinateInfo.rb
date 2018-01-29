# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-12 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapCoordinateInfo < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   @@path = './metadata/spref/horizsys/planar/planci'

   xFile = TestWriterFGDCParent.get_xml('mapCoordinateInfo')
   @@xaExpect = xFile.xpath(@@path)

   def test_coordinate_resolution

      expect = @@xaExpect[0].to_s.squeeze(' ')

      mdHash = TDClass.base
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'planar coordinate encoding method'
      mdHash[:metadata][:resourceInfo][:spatialResolution] = []
      hSpaceRes = TDClass.build_coordinateResolution
      mdHash[:metadata][:resourceInfo][:spatialResolution] << hSpaceRes

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
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

      mdHash = TDClass.base
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'planar coordinate encoding method'
      mdHash[:metadata][:resourceInfo][:spatialResolution] = []
      hSpaceRes = TDClass.build_bearingResolution
      mdHash[:metadata][:resourceInfo][:spatialResolution] << hSpaceRes

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

   end

end
