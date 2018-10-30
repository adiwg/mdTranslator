# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / local system

# History:
#  Stan Smith 2018-10-05 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcLocalSystem < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReferenceLocal.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::HorizontalReference

   def test_planar_localSystem

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys')
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
      assert_empty hProjection[:gridIdentifier]
      refute_empty hProjection[:local]

      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'localSystem', hProjectionId[:identifier]
      assert_equal 'Local Coordinate System', hProjectionId[:name]

      hLocal = hProjection[:local]
      refute hLocal[:fixedToEarth]
      assert_equal 'local description', hLocal[:description]
      assert_equal 'local georeference', hLocal[:georeference]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing local georeference information
      xIn.search('localgeo').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][1]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hLocal = hProjection[:local]
      assert_nil hLocal[:georeference]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: local coordinate system georeference information is missing'

      # missing local description
      xIn.search('localdes').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hPlanar = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      hReferenceSystem = hPlanar[:spatialReferenceSystems][2]
      hParameterSet = hReferenceSystem[:systemParameterSet]
      hProjection = hParameterSet[:projection]
      hLocal = hProjection[:local]
      assert_nil hLocal[:description]

      assert hResponse[:readerExecutionPass]
      assert_equal 2, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: local coordinate system description is missing'

   end

end
