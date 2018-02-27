# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / stereographic projection

# History:
#   Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcStereographic < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_stereographic

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[22]')
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
      assert_equal 'stereographic', hProjection[:projection]
      assert_equal 'Stereographic', hProjection[:projectionName]
      assert_equal 50.0, hProjection[:longitudeOfProjectionCenter]
      assert_equal -50.0, hProjection[:latitudeOfProjectionCenter]
      assert_equal 1000000.0, hProjection[:falseEasting]
      assert_equal 550000.0, hProjection[:falseNorthing]
      assert_equal 'feet', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: planar coordinate encoding method is missing'
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: planar coordinate representation is missing'

   end

end
