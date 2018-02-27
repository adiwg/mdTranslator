# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / oblique mercator projection

# History:
#   Stan Smith 2017-10-17 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcPlanarObliqueMercator < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_obliqueMercator_lineAzimuth

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[13]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hPlanar
      assert_equal 1, hPlanar[:spatialReferenceSystems].length

      hReferenceSystem = hPlanar[:spatialReferenceSystems][0]
      assert_nil hReferenceSystem[:systemType]
      assert_empty hReferenceSystem[:systemIdentifier]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'obliqueMercator', hProjection[:projection]
      assert_equal 'Oblique Mercator', hProjection[:projectionName]
      assert_equal 103.5, hProjection[:scaleFactorAtCenterLine]
      assert_equal 60.0, hProjection[:azimuthAngle]
      assert_equal -110.0, hProjection[:azimuthMeasurePointLongitude]
      assert_equal 25.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 400000, hProjection[:falseNorthing]
      assert_equal 'feet', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: planar coordinate encoding method is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: planar coordinate representation is missing'

   end

   def test_horizontalPlanar_obliqueMercator_linePoint

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[14]')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hPlanar
      assert_equal 1, hPlanar[:spatialReferenceSystems].length

      hReferenceSystem = hPlanar[:spatialReferenceSystems][0]
      assert_nil hReferenceSystem[:systemType]
      assert_empty hReferenceSystem[:systemIdentifier]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'obliqueMercator', hProjection[:projection]
      assert_equal 'Oblique Mercator', hProjection[:projectionName]
      assert_equal 103.5, hProjection[:scaleFactorAtCenterLine]
      assert_equal 2, hProjection[:obliqueLinePoints].length
      assert_equal 20.0, hProjection[:obliqueLinePoints][0][:azimuthLineLatitude]
      assert_equal -105.0, hProjection[:obliqueLinePoints][0][:azimuthLineLongitude]
      assert_equal 30.0, hProjection[:obliqueLinePoints][1][:azimuthLineLatitude]
      assert_equal -115.0, hProjection[:obliqueLinePoints][1][:azimuthLineLongitude]
      assert_equal 25.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 400000, hProjection[:falseNorthing]
      assert_equal 'feet', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: planar coordinate encoding method is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: planar coordinate representation is missing'

   end

end
