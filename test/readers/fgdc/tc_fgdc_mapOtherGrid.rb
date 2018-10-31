# MdTranslator - minitest of
# readers / fgdc / module_horizontalPlanar / other grid

# History:
#  Stan Smith 2018-10-04 original script
#  Stan Smith 2017-10-18 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcOtherGrid < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReferencePlanar.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::PlanarReference

   def test_planar_otherGrid

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys/planar[36]')
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
      assert_equal 'meters', hProjection[:falseEastingNorthingUnits]

      hProjectionId = hProjection[:projectionIdentifier]
      assert_equal 'other', hProjectionId[:identifier]
      assert_equal 'Other Projection', hProjectionId[:name]
      assert_equal 'for description see grid system description', hProjectionId[:description]

      hGridSystemId = hProjection[:gridIdentifier]
      assert_equal 'other', hGridSystemId[:identifier]
      assert_equal 'Other Grid Coordinate System', hGridSystemId[:name]
      assert_equal 'other grid description', hGridSystemId[:description]

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
      assert_equal 'Other Grid Coordinate System', hGridSystemId[:name]

      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: grid system name is missing'

   end

end
