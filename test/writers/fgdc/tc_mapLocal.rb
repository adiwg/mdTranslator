# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-08 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapLocalPlanar < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   def test_map_localPlanar

      path = './metadata/spref/horizsys/planar/localp'

      xFile = TestWriterFGDCParent.get_xml('mapLocal')
      xExpect = xFile.xpath(path)
      expect = xExpect.to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'localPlanar')
      TDClass.add_localDesc(hSpaceRef)
      TDClass.add_localGeoInfo(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

   end

end
