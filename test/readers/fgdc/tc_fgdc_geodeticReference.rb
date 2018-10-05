# MdTranslator - minitest of
# readers / fgdc / module_geodeticReference

# History:
#  Stan Smith 2018-10-06 original script

require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcGeodeticReference < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReferenceGeodetic.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::HorizontalReference

   def test_geodeticReference_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_empty hHorizon
      assert_equal 1, hHorizon[:spatialReferenceSystems].length

      hGeodetic = hHorizon[:spatialReferenceSystems][0]
      assert_nil hGeodetic[:systemType]
      assert_empty hGeodetic[:systemIdentifier]
      refute_empty hGeodetic[:systemParameterSet]

      hGeodeticParams = hGeodetic[:systemParameterSet]
      assert_empty hGeodeticParams[:projection]
      refute_empty hGeodeticParams[:geodetic]
      assert_empty hGeodeticParams[:verticalDatum]

      hGeodeticRef = hGeodeticParams[:geodetic]
      refute_empty hGeodeticRef[:datumIdentifier]
      refute_empty hGeodeticRef[:ellipsoidIdentifier]
      assert_equal 'World Geodetic System of 1984', hGeodeticRef[:datumIdentifier][:identifier]
      assert_equal 'World Geodetic System of 1984', hGeodeticRef[:datumIdentifier][:name]
      assert_equal 'World Geodetic System of 1984', hGeodeticRef[:ellipsoidIdentifier][:identifier]
      assert_equal 'World Geodetic System of 1984', hGeodeticRef[:ellipsoidIdentifier][:name]
      assert_equal 'feet', hGeodeticRef[:axisUnits]
      assert_equal 6378137.0, hGeodeticRef[:semiMajorAxis]
      assert_equal 298.257223563, hGeodeticRef[:denominatorOfFlatteningRatio]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

      # missing denominator of flattening ratio
      xIn.search('denflat').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_nil hHorizon
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: geodetic reference denominator flattening ratio is missing'

      # missing denominator of flattening ratio
      xIn.search('semiaxis').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_nil hHorizon
      assert hResponse[:readerExecutionPass]
      assert_equal 2, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: geodetic reference radius of semi-major axis is missing'

      # missing ellipsoid name
      xIn.search('ellips').remove
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)

      refute_nil hHorizon
      assert hResponse[:readerExecutionPass]
      assert_equal 3, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: FGDC reader: geodetic reference ellipsoid name is missing'

   end

end
