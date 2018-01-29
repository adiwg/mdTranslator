# MdTranslator - minitest of
# writers / fgdc / class_spatialOrganization

# History:
#  Stan Smith 2017-12-21 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSpatialOrganization < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # add spatial reference system
   hIdentifier = TDClass.build_identifier('indirect', 'FGDC', nil, 'indirect reference')
   hRefSystem = TDClass.build_spatialReference(nil, hIdentifier)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

   @@mdHash = mdHash

   def test_spatialOrganization_indirect

      xDoc = TestWriterFGDCParent.get_xml('spatialOrganization')
      axExpect = xDoc.xpath('./metadata/spdoinfo/indspref')
      expect = axExpect[0].to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: @@mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/spdoinfo/indspref')
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got

   end

   def test_spatialOrganization_direct

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # add spatial representation type
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] << 'point'

      xDoc = TestWriterFGDCParent.get_xml('spatialOrganization')
      axExpect = xDoc.xpath('./metadata/spdoinfo/direct')
      expect = axExpect[0].to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/spdoinfo/direct')
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got

   end

   def test_spatialOrganization_vector_sdts

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # point/vector representation
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] << 'vector'

      hVectorRep = TDClass.build_vectorRepresentation
      TDClass.add_vectorObject(hVectorRep, 'sdts type one', 9)
      TDClass.add_vectorObject(hVectorRep, 'sdts type two')
      hSpaceRep = TDClass.build_spatialRepresentation('vector', hVectorRep)
      hIn[:metadata][:resourceInfo][:spatialRepresentation] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

      hVectorRep2 = TDClass.build_vectorRepresentation
      TDClass.add_vectorObject(hVectorRep2, 'sdts type three', 9)
      hSpaceRep2 = TDClass.build_spatialRepresentation('vector', hVectorRep2)
      hIn[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep2

      xDoc = TestWriterFGDCParent.get_xml('spatialOrganization')
      axExpect = xDoc.xpath('./metadata/spdoinfo/ptvctinf')
      expect = axExpect[0].to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/spdoinfo/ptvctinf')
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got

   end

   def test_spatialOrganization_vector_vpt

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # point/vector representation
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] << 'vector'

      # grid representation
      hVectorRep = TDClass.build_vectorRepresentation('2')
      TDClass.add_vectorObject(hVectorRep, 'vpf type one', 999)
      TDClass.add_vectorObject(hVectorRep, 'vpf type two')
      hSpaceRep = TDClass.build_spatialRepresentation('vector', hVectorRep)
      hIn[:metadata][:resourceInfo][:spatialRepresentation] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

      xDoc = TestWriterFGDCParent.get_xml('spatialOrganization')
      axExpect = xDoc.xpath('./metadata/spdoinfo/ptvctinf')
      expect = axExpect[1].to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/spdoinfo/ptvctinf')
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got

   end

   def test_spatialOrganization_raster

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # point/vector representation
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentationType] << 'grid'

      # grid representation
      hGridRep = TDClass.build_gridRepresentation(3, 'raster type')
      TDClass.add_dimension(hGridRep, 'row', 999)
      TDClass.add_dimension(hGridRep, 'column', 99)
      TDClass.add_dimension(hGridRep, 'vertical', 9)
      hSpaceRep = TDClass.build_spatialRepresentation('grid', hGridRep)
      hIn[:metadata][:resourceInfo][:spatialRepresentation] = []
      hIn[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

      xDoc = TestWriterFGDCParent.get_xml('spatialOrganization')
      axExpect = xDoc.xpath('./metadata/spdoinfo/rastinfo')
      expect = axExpect.to_s.squeeze(' ')

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath('./metadata/spdoinfo/rastinfo')
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got

   end

end
