# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / state plane coordinate grid

# History:
#  Stan Smith 2018-10-04 original script
#  Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcStatePlane < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReferencePlanar.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_planar_statePlane_lambertC

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
      assert_nil hReferenceSystem[:systemWKT]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      refute_empty hProjection[:gridSystemIdentifier]
      assert_equal 'alaska zone 9', hProjection[:gridZone]
      assert_equal 50.0, hProjection[:standardParallel1]
      assert_equal 55.0, hProjection[:standardParallel2]
      assert_equal -160.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 0.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 500000, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hGridSystemId = hProjection[:gridSystemIdentifier]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'spcs', hGridSystemId[:identifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]
      assert_equal 'lambertConic', hProjectionId[:identifier]
      assert_equal 'Lambert Conformal Conic', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing grid system name
      xIn.search('gridsysn').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hGridSystemId = hProjection[:gridSystemIdentifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

   def test_planar_statePlane_tranMercator

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
      assert_nil hReferenceSystem[:systemWKT]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      refute_empty hProjection[:gridSystemIdentifier]
      assert_equal 'alaska zone 8', hProjection[:gridZone]
      assert_equal 0.45, hProjection[:scaleFactorAtCentralMeridian]
      assert_equal -160.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 50.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 600000.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hGridSystemId = hProjection[:gridSystemIdentifier]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'spcs', hGridSystemId[:identifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]
      assert_equal 'transverseMercator', hProjectionId[:identifier]
      assert_equal 'Transverse Mercator', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing grid system name
      xIn.search('gridsysn').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hGridSystemId = hProjection[:gridSystemIdentifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

   def test_planar_statePlane_obliqueMerc_azimuth

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
      assert_nil hReferenceSystem[:systemWKT]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      refute_empty hProjection[:gridSystemIdentifier]
      assert_equal 'alaska zone 7', hProjection[:gridZone]
      assert_equal 0.55, hProjection[:scaleFactorAtCenterLine]
      assert_equal 15.0, hProjection[:azimuthAngle]
      assert_equal -160.0, hProjection[:azimuthMeasurePointLongitude]
      assert_equal 55.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 400000, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hGridSystemId = hProjection[:gridSystemIdentifier]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'spcs', hGridSystemId[:identifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]
      assert_equal 'obliqueMercator', hProjectionId[:identifier]
      assert_equal 'Oblique Mercator', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing grid system name
      xIn.search('gridsysn').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hGridSystemId = hProjection[:gridSystemIdentifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

   def test_planar_statePlane_obliqueMerc_point

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
      assert_nil hReferenceSystem[:systemWKT]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      refute_empty hProjection[:gridSystemIdentifier]
      assert_equal 'alaska zone 6', hProjection[:gridZone]
      assert_equal 0.55, hProjection[:scaleFactorAtCenterLine]
      assert_equal 2, hProjection[:obliqueLinePoints].length
      assert_equal 45.0, hProjection[:obliqueLinePoints][0][:obliqueLineLatitude]
      assert_equal -155.0, hProjection[:obliqueLinePoints][0][:obliqueLineLongitude]
      assert_equal 55.0, hProjection[:obliqueLinePoints][1][:obliqueLineLatitude]
      assert_equal -165.0, hProjection[:obliqueLinePoints][1][:obliqueLineLongitude]
      assert_equal 55.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 400000, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hGridSystemId = hProjection[:gridSystemIdentifier]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'spcs', hGridSystemId[:identifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]
      assert_equal 'obliqueMercator', hProjectionId[:identifier]
      assert_equal 'Oblique Mercator', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing grid system name
      xIn.search('gridsysn').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hGridSystemId = hProjection[:gridSystemIdentifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

   def test_planar_statePlane_polyconic

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
      assert_nil hReferenceSystem[:systemWKT]
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      refute_empty hProjection[:projectionIdentifier]
      refute_empty hProjection[:gridSystemIdentifier]
      assert_equal 'alaska zone 5', hProjection[:gridZone]
      assert_equal -155.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 61.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 450000.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hGridSystemId = hProjection[:gridSystemIdentifier]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'spcs', hGridSystemId[:identifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]
      assert_equal 'polyconic', hProjectionId[:identifier]
      assert_equal 'Polyconic', hProjectionId[:name]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing grid system name
      xIn.search('gridsysn').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hGridSystemId = hProjection[:gridSystemIdentifier]
      assert_equal 'State Plane Coordinate System', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

end
