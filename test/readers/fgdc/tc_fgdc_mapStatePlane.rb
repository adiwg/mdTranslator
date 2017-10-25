# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / state plane coordinate grid

# History:
#   Stan Smith 2017-10-18 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcStatePlane < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_statePlane_lambertC

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[29]')
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
      assert_empty hParameterSet[:ellipsoid]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'lambert conformal conic', hProjection[:projectionName]
      assert_equal 'alaska zone 9', hProjection[:zone]
      assert_equal 50.0, hProjection[:standardParallel1]
      assert_equal 55.0, hProjection[:standardParallel2]
      assert_equal -160.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 0.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 500000, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_horizontalPlanar_statePlane_transverseM

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[30]')
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
      assert_empty hParameterSet[:ellipsoid]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'transverse mercator', hProjection[:projectionName]
      assert_equal 'alaska zone 8', hProjection[:zone]
      assert_equal 0.45, hProjection[:scaleFactorAtCentralMeridian]
      assert_equal -160.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 50.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 600000.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_horizontalPlanar_statePlane_obliqueM_azimuth

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[31]')
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
      assert_empty hParameterSet[:ellipsoid]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'oblique mercator', hProjection[:projectionName]
      assert_equal 'alaska zone 7', hProjection[:zone]
      assert_equal 0.55, hProjection[:scaleFactorAtCenterLine]
      assert_equal 15.0, hProjection[:azimuthAngle]
      assert_equal -160.0, hProjection[:azimuthMeasurePointLongitude]
      assert_equal 55.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 400000, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_horizontalPlanar_statePlane_obliqueM_point

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[32]')
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
      assert_empty hParameterSet[:ellipsoid]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'oblique mercator', hProjection[:projectionName]
      assert_equal 'alaska zone 6', hProjection[:zone]
      assert_equal 0.55, hProjection[:scaleFactorAtCenterLine]
      assert_equal 2, hProjection[:obliqueLinePoints].length
      assert_equal 45.0, hProjection[:obliqueLinePoints][0][:azimuthLineLatitude]
      assert_equal -155.0, hProjection[:obliqueLinePoints][0][:azimuthLineLongitude]
      assert_equal 55.0, hProjection[:obliqueLinePoints][1][:azimuthLineLatitude]
      assert_equal -165.0, hProjection[:obliqueLinePoints][1][:azimuthLineLongitude]
      assert_equal 55.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 400000, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_horizontalPlanar_statePlane_polyconic

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[33]')
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
      assert_empty hParameterSet[:ellipsoid]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      assert_equal 'polyconic', hProjection[:projectionName]
      assert_equal 'alaska zone 5', hProjection[:zone]
      assert_equal -155.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 61.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 450000.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
