# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-15 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcLocalSystem < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   def test_map_localSystem

      path = './metadata/spref/horizsys/local'

      xFile = TestReaderFgdcParent.get_xml('localSystem')
      xExpect = xFile.xpath(path)
      expect = xExpect.to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'local')
      TDClass.add_localDesc(hSpaceRef, 'local description')
      TDClass.add_localGeoInfo(hSpaceRef, 'local georeference information')
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
