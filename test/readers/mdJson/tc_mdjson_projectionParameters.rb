# MdTranslator - minitest of
# reader / mdJson / module_projectionParameters

# History:
#  Stan Smith 2018-06-22 refactored to use mdJson construction helpers
#  Stan Smith 2017-10-23 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_projectionParameters'

class TestReaderMdJsonProjectionParameters < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ProjectionParameters

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.projection
   mdHash[:obliqueLinePoint] << TDClass.obliqueLinePoint
   mdHash[:obliqueLinePoint] << TDClass.obliqueLinePoint

   @@mdHash = mdHash

   # TODO complete after schema update
   # def test_spatialReference_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'spatialReference.json')
   #     assert_empty errors
   #
   # end

   def test_complete_projectionParameters_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_empty metadata[:projectionIdentifier]
      assert_equal 'projection identifier', metadata[:projectionIdentifier][:identifier]
      assert_equal 'grid system', metadata[:gridSystem]
      assert_equal 'grid system name', metadata[:gridSystemName]
      assert_equal 'zone 4', metadata[:gridZone]
      assert_equal 'projection code', metadata[:projection]
      assert_equal 'projection name', metadata[:projectionName]
      assert_equal 9.9, metadata[:standardParallel1]
      assert_equal 9.9, metadata[:standardParallel2]
      assert_equal 9.9, metadata[:longitudeOfCentralMeridian]
      assert_equal 9.9, metadata[:latitudeOfProjectionOrigin]
      assert_equal 9.9, metadata[:falseEasting]
      assert_equal 9.9, metadata[:falseNorthing]
      assert_equal 'false units', metadata[:falseEastingNorthingUnits]
      assert_equal 9.9, metadata[:scaleFactorAtEquator]
      assert_equal 9.9, metadata[:heightOfProspectivePointAboveSurface]
      assert_equal 9.9, metadata[:longitudeOfProjectionCenter]
      assert_equal 9.9, metadata[:latitudeOfProjectionCenter]
      assert_equal 9.9, metadata[:scaleFactorAtCenterLine]
      assert_equal 9.9, metadata[:scaleFactorAtCentralMeridian]
      assert_equal 9.9, metadata[:straightVerticalLongitudeFromPole]
      assert_equal 9.9, metadata[:scaleFactorAtProjectionOrigin]
      assert_equal 9.9, metadata[:azimuthAngle]
      assert_equal 9.9, metadata[:azimuthMeasurePointLongitude]

      assert_equal 2, metadata[:obliqueLinePoints].length
      assert_equal 99.9, metadata[:obliqueLinePoints][0][:azimuthLineLatitude]
      assert_equal 99.9, metadata[:obliqueLinePoints][0][:azimuthLineLongitude]
      assert_equal 99.9, metadata[:obliqueLinePoints][1][:azimuthLineLatitude]
      assert_equal 99.9, metadata[:obliqueLinePoints][1][:azimuthLineLongitude]

      assert_equal 9, metadata[:landsatNumber]
      assert_equal 9, metadata[:landsatPath]
      assert_equal 'local planar description', metadata[:localPlanarDescription]
      assert_equal 'local planar georeference', metadata[:localPlanarGeoreference]
      assert_equal 'other projection description', metadata[:otherProjectionDescription]
      assert_equal 'other grid description', metadata[:otherGridDescription]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_projectionParameters_empty_projection

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['projection'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: projection parameters projection code is missing: CONTEXT is testing'

   end

   def test_projectionParameters_missing_projection

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('projection')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: projection parameters projection code is missing: CONTEXT is testing'

   end

   def test_empty_projectionParameters_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: projection parameters object is empty: CONTEXT is testing'

   end

end
