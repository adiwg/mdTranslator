# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / local system

# History:
#   Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcPlanarLocal < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_horizontalPlanar_local

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[37]')
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
      assert_empty hProjection[:projectionIdentifier]
      assert_equal 'localPlanar', hProjection[:projection]
      assert_equal 'local planar coordinate system', hProjection[:projectionName]
      assert_equal 'local planar description', hProjection[:localPlanarDescription]
      assert_equal 'local planar georeference information', hProjection[:localPlanarGeoreference]
      assert_equal 'feet', hProjection[:falseEastingNorthingUnits]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: FGDC reader: planar coordinate encoding method is missing'
      assert_includes hResponse[:readerExecutionMessages], 
                      'WARNING: FGDC reader: planar coordinate representation is missing'

   end

end
