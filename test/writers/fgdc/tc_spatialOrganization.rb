# MdTranslator - minitest of
# writers / fgdc / class_spatialOrganization

# History:
#  Stan Smith 2017-12-21 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcSpatialOrganization < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # add spatial reference system
   hIdentifier = TDClass.build_identifier('indirect', 'FGDC', nil, 'indirect reference')
   hRefSystem = TDClass.build_spatialReference(nil, hIdentifier)
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hRefSystem

   # add spatial representation type
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'point'

   # add spatial representation
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   hSpaceRep = mdHash[:metadata][:resourceInfo][:spatialRepresentation]
   hSpaceRep << { vectorRepresentation: TDClass.build_vectorRepresentation_full }
   hSpaceRep << { gridRepresentation: TDClass.build_gridRepresentation }
   hSpaceRep << { vectorRepresentation: TDClass.build_vectorRepresentation_full }
   hSpaceRep << { georeferenceableRepresentation: TDClass.build_georeferenceableRepresentation }

   # set dimension type
   hSpaceRep = mdHash[:metadata][:resourceInfo][:spatialRepresentation]
   hSpaceRep[1][:gridRepresentation][:dimension][0][:dimensionType] = 'row'
   hSpaceRep[1][:gridRepresentation][:dimension][1][:dimensionType] = 'column'
   TDClass.add_dimension(hSpaceRep[1][:gridRepresentation], 'vertical', 9)

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

   # vector representation w/o topology level
   def test_spatialOrganization_vector_sdts

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:vectorRepresentation].delete(:topologyLevel)
      hIn[:metadata][:resourceInfo][:spatialRepresentation][2][:vectorRepresentation].delete(:topologyLevel)

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

   # vector representation w/ topology level
   def test_spatialOrganization_vector_vpt

      hIn = Marshal::load(Marshal.dump(@@mdHash))

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
