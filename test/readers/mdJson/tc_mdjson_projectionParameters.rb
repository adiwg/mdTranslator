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
      refute_empty metadata[:gridSystemIdentifier]
      assert_equal 'zone 4', metadata[:gridZone]
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
      assert_equal 9, metadata[:landsatNumber]
      assert_equal 9, metadata[:landsatPath]
      assert_equal 2, metadata[:obliqueLinePoints].length
      refute_empty metadata[:local]

      aOblique = metadata[:obliqueLinePoints]
      assert_equal 11.1, aOblique[0][:obliqueLineLatitude]
      assert_equal 22.2, aOblique[0][:obliqueLineLongitude]
      assert_equal 11.1, aOblique[1][:obliqueLineLatitude]
      assert_equal 22.2, aOblique[1][:obliqueLineLongitude]

      hLocal = metadata[:local]
      refute hLocal[:fixedToEarth]
      assert_equal 'local description', hLocal[:description]
      assert_equal 'local georeference', hLocal[:georeference]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_projectionParameters_empty_projection

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['projectionIdentifier'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: projection identifier is missing: CONTEXT is testing'

   end

   def test_projectionParameters_missing_projection

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('projectionIdentifier')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: projection identifier is missing: CONTEXT is testing'

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
