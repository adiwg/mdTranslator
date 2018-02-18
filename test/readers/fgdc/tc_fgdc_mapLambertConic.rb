# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / lambert conformal conic projection

# History:
#   Stan Smith 2017-10-16 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcPlanarLambertConic < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_lambertConformalConic

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[8]')
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
      assert_equal 'lambertConic', hProjection[:projection]
      assert_equal 'Lambert Conformal Conic', hProjection[:projectionName]
      assert_equal 20.0, hProjection[:standardParallel1]
      assert_equal 40.0, hProjection[:standardParallel2]
      assert_equal -100.0, hProjection[:longitudeOfCentralMeridian]
      assert_equal 30.0, hProjection[:latitudeOfProjectionOrigin]
      assert_equal 1000000, hProjection[:falseEasting]
      assert_equal 700000, hProjection[:falseNorthing]
      assert_equal 'feet', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC planar coordinate encoding method is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC planar coordinate representation is missing'

   end

end
