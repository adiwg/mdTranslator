# MdTranslator - minitest of
# reader / mdJson / module_projectionParameters

# History:
#   Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_projectionParameters'

class TestReaderMdJsonProjectionParameters < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ProjectionParameters
   aIn = TestReaderMdJsonParent.getJson('spatialReference.json')
   @@hIn = aIn['spatialReferenceSystem'][0]['referenceSystemParameterSet']['projection']

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@hIn, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_projectionParameters_object

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:projectionIdentifier]
      assert_equal 'identifier', metadata[:projectionIdentifier][:identifier]
      assert_equal 'grid system', metadata[:gridSystem]
      assert_equal 'grid system name', metadata[:gridSystemName]
      assert_equal 'zone 8', metadata[:gridZone]
      assert_equal 'projection', metadata[:projection]
      assert_equal 'projection name', metadata[:projectionName]
      assert_equal 9.0, metadata[:standardParallel1]
      assert_equal 99.0, metadata[:standardParallel2]
      assert_equal -9.0, metadata[:longitudeOfCentralMeridian]
      assert_equal 9.0, metadata[:latitudeOfProjectionOrigin]
      assert_equal 99999.0, metadata[:falseEasting]
      assert_equal 999999.0, metadata[:falseNorthing]
      assert_equal 'feet', metadata[:falseEastingNorthingUnits]
      assert_equal 99.9, metadata[:scaleFactorAtEquator]
      assert_equal 999.0, metadata[:heightOfProspectivePointAboveSurface]
      assert_equal -99.0, metadata[:longitudeOfProjectionCenter]
      assert_equal 9.0, metadata[:latitudeOfProjectionCenter]
      assert_equal 99.9, metadata[:scaleFactorAtCenterLine]
      assert_equal 9.9, metadata[:scaleFactorAtCentralMeridian]
      assert_equal 999.9, metadata[:straightVerticalLongitudeFromPole]
      assert_equal 99.9, metadata[:scaleFactorAtProjectionOrigin]
      assert_equal 9.9, metadata[:azimuthAngle]
      assert_equal -99.0, metadata[:azimuthMeasurePointLongitude]

      assert_equal 2, metadata[:obliqueLinePoints].length
      assert_equal 9.9, metadata[:obliqueLinePoints][0][:azimuthLineLatitude]
      assert_equal -99.9, metadata[:obliqueLinePoints][0][:azimuthLineLongitude]
      assert_equal 19.9, metadata[:obliqueLinePoints][1][:azimuthLineLatitude]
      assert_equal -109.9, metadata[:obliqueLinePoints][1][:azimuthLineLongitude]

      assert_equal 9, metadata[:landsatNumber]
      assert_equal 9999, metadata[:landsatPath]
      assert_equal 'local planar description', metadata[:localPlanarDescription]
      assert_equal 'local planar georeference', metadata[:localPlanarGeoreference]
      assert_equal 'other projection description', metadata[:otherProjectionDescription]
      assert_equal 'other grid description', metadata[:otherGridDescription]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_projectionParameters_missing_projection

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn.delete('projection')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_projectionParameters_empty_projection

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['projection'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_projectionParameters_object

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

end
