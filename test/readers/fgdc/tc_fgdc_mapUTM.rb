# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / universal transverse mercator grid

# History:
#  Stan Smith 2018-10-04 refactor mdJson projection object
#  Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcUTM < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReferencePlanar.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_planar_UTM

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[26]')
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
      refute_empty hProjection[:gridIdentifier]
      assert_equal '9', hProjection[:gridZone]
      assert_equal 9.9, hProjection[:scaleFactorAtCentralMeridian]
      assert_equal -99.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 19.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 750000.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hGridSystemId = hProjection[:gridIdentifier]
      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'utm', hGridSystemId[:identifier]
      assert_equal 'Universal Transverse Mercator', hGridSystemId[:name]
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
      hGridSystemId = hProjection[:gridIdentifier]
      assert_equal 'Universal Transverse Mercator', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

end
