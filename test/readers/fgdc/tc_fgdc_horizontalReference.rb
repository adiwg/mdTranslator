# MdTranslator - minitest of
# readers / fgdc / module_horizontalReference

# History:
#   Stan Smith 2017-10-04 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcHorizontalReference < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('spatialReference.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::HorizontalReference

   def test_horizontalReference_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/spref/horizsys')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hHorizon = @@NameSpace.unpack(xIn, hResourceInfo, hResponse)
      numProjections = 39

      refute_empty hHorizon
      assert_equal 3, hHorizon[:spatialResolutions].length

      hResolution = hHorizon[:spatialResolutions][0]
      assert_nil hResolution[:scaleFactor]
      assert_empty hResolution[:measure]
      refute_empty hResolution[:geographicResolution]
      assert_nil hResolution[:levelOfDetail]

      hGeoResolution = hResolution[:geographicResolution]
      assert_equal 0.00009, hGeoResolution[:latitudeResolution]
      assert_equal 0.00004, hGeoResolution[:longitudeResolution]
      assert_equal 'decimal degrees', hGeoResolution[:unitOfMeasure]

      assert_equal numProjections, hHorizon[:spatialReferenceSystems].length

      hLocal = hHorizon[:spatialReferenceSystems][numProjections-2]
      assert_nil hLocal[:systemType]
      assert_empty hLocal[:systemIdentifier]
      refute_empty hLocal[:systemParameterSet]

      hLocalParams = hLocal[:systemParameterSet]
      refute_empty hLocalParams[:projection]
      assert_empty hLocalParams[:ellipsoid]
      assert_empty hLocalParams[:verticalDatum]

      hLocalProjection = hLocalParams[:projection]
      assert_empty hLocalProjection[:projectionIdentifier]
      assert_equal 'local', hLocalProjection[:projectionName]
      assert_equal 'local description', hLocalProjection[:localPlanarDescription]
      assert_equal 'local georeference information', hLocalProjection[:localPlanarGeoreference]

      hGeodetic = hHorizon[:spatialReferenceSystems][numProjections-1]
      assert_nil hGeodetic[:systemType]
      assert_empty hGeodetic[:systemIdentifier]
      refute_empty hGeodetic[:systemParameterSet]

      hGeodeticParams = hGeodetic[:systemParameterSet]
      assert_empty hGeodeticParams[:projection]
      refute_empty hGeodeticParams[:ellipsoid]
      assert_empty hGeodeticParams[:verticalDatum]

      hGeodeticProjection = hGeodeticParams[:ellipsoid]
      refute_empty hGeodeticProjection[:ellipsoidIdentifier]
      identifier = hGeodeticProjection[:ellipsoidIdentifier][:identifier]
      assert_equal 'World Geodetic System of 1984 identifier', identifier
      assert_equal 'World Geodetic System of 1984', hGeodeticProjection[:ellipsoidName]
      assert_equal 6378137.0, hGeodeticProjection[:semiMajorAxis]
      assert_equal 'feet', hGeodeticProjection[:axisUnits]
      assert_equal 298.257223563, hGeodeticProjection[:denominatorOfFlatteningRatio]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
