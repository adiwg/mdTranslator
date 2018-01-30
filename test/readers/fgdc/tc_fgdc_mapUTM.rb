# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / universal transverse mercator grid

# History:
#   Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcUTM < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_UTM

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
      refute_empty hReferenceSystem[:systemParameterSet]

      hParameterSet = hReferenceSystem[:systemParameterSet]
      refute_empty hParameterSet[:projection]
      assert_empty hParameterSet[:geodetic]
      assert_empty hParameterSet[:verticalDatum]

      hProjection = hParameterSet[:projection]
      assert_equal 'utm', hProjection[:gridSystem]
      assert_equal 'universal transverse mercator UTM grid system', hProjection[:gridSystemName]
      assert_equal 'transverseMercator', hProjection[:projection]
      assert_equal 'Transverse Mercator', hProjection[:projectionName]
      assert_equal '9', hProjection[:gridZone]
      assert_equal 9.9, hProjection[:scaleFactorAtCentralMeridian]
      assert_equal -99.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 19.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 750000.0, hProjection[:falseNorthing]
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
