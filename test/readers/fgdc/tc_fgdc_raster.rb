# MdTranslator - minitest of
# readers / fgdc / module_raster

# History:
#   Stan Smith 2017-09-04 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcRaster < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('raster.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::SpatialOrganization

   def test_raster_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spdoinfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hResInfo = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hResInfo
      assert_equal 1, hResInfo[:spatialReferenceSystems].length
      assert_equal 1, hResInfo[:spatialRepresentationTypes].length
      assert_equal 'grid', hResInfo[:spatialRepresentationTypes][0]
      assert_equal 1, hResInfo[:spatialRepresentations].length

      hRefSystem = hResInfo[:spatialReferenceSystems][0]
      assert_nil hRefSystem[:systemType]
      refute_empty hRefSystem[:systemIdentifier]

      hIdentifier = hRefSystem[:systemIdentifier]
      assert_equal 'indirect', hIdentifier[:identifier]
      assert_equal 'FGDC', hIdentifier[:namespace]
      assert_equal 'indirect reference', hIdentifier[:description]

      hSpatialRep = hResInfo[:spatialRepresentations][0]
      refute_empty hSpatialRep[:gridRepresentation]
      assert_empty hSpatialRep[:vectorRepresentation]
      assert_empty hSpatialRep[:georectifiedRepresentation]
      assert_empty hSpatialRep[:georeferenceableRepresentation]

      hGrid = hSpatialRep[:gridRepresentation]
      assert_equal 3, hGrid[:numberOfDimensions]
      assert_equal 3, hGrid[:dimension].length
      assert_equal 'pixel', hGrid[:cellGeometry]

      hDimension = hGrid[:dimension][0]
      assert_equal 'row', hDimension[:dimensionType]
      assert_nil hDimension[:dimensionTitle]
      assert_nil hDimension[:dimensionDescription]
      assert_equal 999, hDimension[:dimensionSize]
      assert_empty hDimension[:resolution]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
