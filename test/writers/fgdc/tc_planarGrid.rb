# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-10-09 refactor mdJson projection object
#  Stan Smith 2018-01-08 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapGridSystem < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # read the fgdc reference file
   @@path = './metadata/spref/horizsys/planar/gridsys'
   xFile = TestWriterFGDCParent.get_xml('mapGridSystem')
   @@axExpect = xFile.xpath(@@path)

   def get_response(hProjection)

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      hSpaceRef[:referenceSystemParameterSet][:projection] = hProjection
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] = []
      mdHash[:metadata][:resourceInfo][:spatialRepresentationType] << 'spatial representation type'

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      return hResponseObj

   end

   # grid system - utm
   def test_mapGrid_utm

      expect = @@axExpect[0].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('transverseMercator', 'Transverse Mercator')
      TDClass.add_grid(hProjection, 'utm', '9', 'Universal Transverse Mercator', 'description')
      TDClass.add_scaleFactorCM(hProjection)
      TDClass.add_longCM(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid universal transverse mercator zone is missing: CONTEXT is spatial reference horizontal planar grid system utm'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid universal transverse mercator zone is missing: CONTEXT is spatial reference horizontal planar grid system utm'

   end

   # grid system - ups (standard parallel)
   def test_mapGrid_upsSP

      expect = @@axExpect[1].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('polarStereo', 'Universal Polar Stereographic')
      TDClass.add_grid(hProjection, 'ups', 'B', 'Universal Polar Stereographic')
      TDClass.add_straightFromPole(hProjection)
      TDClass.add_standardParallel(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid universal polar stereographic zone is missing: CONTEXT is spatial reference horizontal planar grid system ups'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid universal polar stereographic zone is missing: CONTEXT is spatial reference horizontal planar grid system ups'

   end

   # grid system - ups (scale factor)
   def test_mapGrid_upsSF

      expect = @@axExpect[2].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('polarStereo', 'Universal Polar Stereographic')
      TDClass.add_grid(hProjection, 'ups', 'B', 'Universal Polar Stereographic')
      TDClass.add_straightFromPole(hProjection)
      TDClass.add_scaleFactorPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid universal polar stereographic zone is missing: CONTEXT is spatial reference horizontal planar grid system ups'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid universal polar stereographic zone is missing: CONTEXT is spatial reference horizontal planar grid system ups'

   end

   # grid system - state plane coordinate system (lambert conformal conic)
   def test_mapGrid_spcs_lambert

      expect = @@axExpect[3].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('lambertConic', 'Lambert Conformal Conic')
      TDClass.add_grid(hProjection, 'spcs', '9', 'Alaska State Plane Coordinate System')
      TDClass.add_standardParallel(hProjection, 2)
      TDClass.add_longCM(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

   end

   # grid system - state plane coordinate system (transverse mercator)
   def test_mapGrid_spcs_transMercator

      expect = @@axExpect[4].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('transverseMercator', 'Transverse Mercator')
      TDClass.add_grid(hProjection, 'spcs', '8', 'Alaska State Plane Coordinate System')
      TDClass.add_scaleFactorCM(hProjection)
      TDClass.add_longCM(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

   end

   # grid system - state plane coordinate system (oblique mercator - line azimuth)
   def test_mapGrid_spcs_obliqueMercatorLA

      expect = @@axExpect[5].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('obliqueMercator', 'Oblique Mercator - Line Azimuth')
      TDClass.add_grid(hProjection, 'spcs', '7', 'Alaska State Plane Coordinate System')
      TDClass.add_scaleFactorCL(hProjection)
      TDClass.add_obliqueLineAzimuth(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

   end

   # grid system - state plane coordinate system (oblique mercator - line point)
   def test_mapGrid_spcs_obliqueMercatorLP

      expect = @@axExpect[6].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('obliqueMercator', 'Oblique Mercator - Line Point')
      TDClass.add_grid(hProjection, 'spcs', '6', 'Alaska State Plane Coordinate System')
      TDClass.add_scaleFactorCL(hProjection)
      TDClass.add_obliqueLinePoint(hProjection)
      TDClass.add_obliqueLinePoint(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

   end

   # grid system - state plane coordinate system (polyconic)
   def test_mapGrid_spcs_polyconic

      expect = @@axExpect[7].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('polyconic', 'Polyconic')
      TDClass.add_grid(hProjection, 'spcs', '5', 'Alaska State Plane Coordinate System')
      TDClass.add_longCM(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid state plane coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system spcs'

   end

   # grid system - equal arc-second coordinate system (equirectangular)
   def test_mapGrid_arcsys_equirectangular

      expect = @@axExpect[8].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('equirectangular', 'Equirectangular')
      TDClass.add_grid(hProjection, 'arcsys', '10', 'Equal Arc-Second Coordinate System')
      TDClass.add_standardParallel(hProjection, 1)
      TDClass.add_longCM(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid equal arc-second coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system arcsys'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid equal arc-second coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system arcsys'

   end

   # grid system - equal arc-second coordinate system (azimuthal equidistant)
   def test_mapGrid_arcsys_azimuthalEquidistant

      expect = @@axExpect[9].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('azimuthalEquidistant', 'Azimuthal Equidistant')
      TDClass.add_grid(hProjection, 'arcsys', '10', 'Equal Arc-Second Coordinate System')
      TDClass.add_longCM(hProjection)
      TDClass.add_latPO(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty Zone
      hProjection[:gridZone] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid equal arc-second coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system arcsys'

      # test missing Zone
      hProjection.delete(:gridZone)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid equal arc-second coordinate system zone is missing: CONTEXT is spatial reference horizontal planar grid system arcsys'

   end

   # grid system - other grid system
   def test_mapGrid_other

      expect = @@axExpect[10].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('other', 'Other Projection', 'see grid identifier description')
      TDClass.add_grid(hProjection, 'other', nil, 'Other Grid Coordinate System', 'other grid description')

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty definitions
      hProjection[:projectionIdentifier][:description] = ''
      hProjection[:gridSystemIdentifier][:description] = ''

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid description is missing: CONTEXT is spatial reference horizontal planar grid system other'

      # test missing definitions
      hProjection[:projectionIdentifier].delete(:description)
      hProjection[:gridSystemIdentifier].delete(:description)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map grid description is missing: CONTEXT is spatial reference horizontal planar grid system other'

      # test empty projection
      hProjection[:projectionIdentifier] = {}

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:readerExecutionPass]
      assert_equal 1, hResponseObj[:readerExecutionMessages].length
      assert_includes hResponseObj[:readerExecutionMessages], 'ERROR: mdJson reader: projection identifier is missing: CONTEXT is spatial reference system reference system parameter set'

      # test missing projection
      hProjection[:projectionIdentifier].delete(:description)
      hProjection[:gridSystemIdentifier].delete(:description)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:readerExecutionPass]
      assert_equal 1, hResponseObj[:readerExecutionMessages].length
      assert_includes hResponseObj[:readerExecutionMessages], 'ERROR: mdJson reader: projection identifier is missing: CONTEXT is spatial reference system reference system parameter set'

   end

end
