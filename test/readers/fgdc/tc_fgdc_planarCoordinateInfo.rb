# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / coordinate information

# History:
#  Stan Smith 2017-10-19 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcCoordinateInfo < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialResolutionPlanar.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_coordinateInfo

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hPlanar
      assert_equal 1, hPlanar[:spatialRepresentationTypes].length
      assert_equal 2, hPlanar[:spatialResolutions].length

      assert_equal 'planar coordinate encoding method', hPlanar[:spatialRepresentationTypes][0]

      hResolution0 = hPlanar[:spatialResolutions][0]
      assert_nil hResolution0[:scaleFactor]
      assert_empty hResolution0[:measure]
      refute_empty hResolution0[:coordinateResolution]
      assert_empty hResolution0[:bearingDistanceResolution]
      assert_empty hResolution0[:geographicResolution]
      assert_nil hResolution0[:levelOfDetail]

      hCoordinateRes = hResolution0[:coordinateResolution]
      assert_equal 9.9, hCoordinateRes[:abscissaResolutionX]
      assert_equal 99.9, hCoordinateRes[:ordinateResolutionY]
      assert_equal 'feet', hCoordinateRes[:unitOfMeasure]

      hResolution1 = hPlanar[:spatialResolutions][1]
      assert_nil hResolution1[:scaleFactor]
      assert_empty hResolution1[:measure]
      assert_empty hResolution1[:coordinateResolution]
      refute_empty hResolution1[:bearingDistanceResolution]
      assert_empty hResolution1[:geographicResolution]
      assert_nil hResolution1[:levelOfDetail]

      hBearingDistRes = hResolution1[:bearingDistanceResolution]
      assert_equal 99.99, hBearingDistRes[:distanceResolution]
      assert_equal 'feet', hBearingDistRes[:distanceUnitOfMeasure]
      assert_equal 9.99, hBearingDistRes[:bearingResolution]
      assert_equal 'bearing units', hBearingDistRes[:bearingUnitsOfMeasure]
      assert_equal 'bearing direction', hBearingDistRes[:bearingReferenceDirection]
      assert_equal 'bearing meridian', hBearingDistRes[:bearingReferenceMeridian]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
