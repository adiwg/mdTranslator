# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-03 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapProjection < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # read the fgdc reference file
   @@path = './metadata/spref/horizsys/planar/mapproj'
   xFile = TestWriterFGDCParent.get_xml('mapProjection')
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

   def test_mapProjection_alaska

      expect = @@axExpect[0].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('alaska', 'Alaska Modified Stereographic')
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection alaska'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection alaska'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 2, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection alaska'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection alaska'

   end

   # map projections - albers
   def test_mapProjection_albers

      expect = @@axExpect[1].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('albers', 'Albers Conical Equal Area')
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

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:standardParallel1] = nil
      hProjection[:standardParallel2] = nil
      hProjection[:longitudeOfCentralMeridian] = nil
      hProjection[:latitudeOfProjectionOrigin] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection albers'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:standardParallel1)
      hProjection.delete(:standardParallel2)
      hProjection.delete(:longitudeOfCentralMeridian)
      hProjection.delete(:latitudeOfProjectionOrigin)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection albers'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection albers'

   end

   # map projections - azimuthal equidistant
   def test_mapProjection_azimuthalEquidistant

      expect = @@axExpect[2].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('azimuthalEquidistant', 'Azimuthal Equidistant')
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

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:longitudeOfCentralMeridian] = nil
      hProjection[:latitudeOfProjectionOrigin] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:longitudeOfCentralMeridian)
      hProjection.delete(:latitudeOfProjectionOrigin)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection azimuthalEquidistant'

   end

   # map projections - equidistant conic
   def test_mapProjection_equidistantConic

      expect = @@axExpect[3].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('equidistantConic', 'Equidistant Conic')
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

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:standardParallel1] = nil
      hProjection[:standardParallel2] = nil
      hProjection[:longitudeOfCentralMeridian] = nil
      hProjection[:latitudeOfProjectionOrigin] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:standardParallel1)
      hProjection.delete(:standardParallel2)
      hProjection.delete(:longitudeOfCentralMeridian)
      hProjection.delete(:latitudeOfProjectionOrigin)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection equidistantConic'

   end

   # map projections - equirectangular
   def test_mapProjection_equirectangular

      expect = @@axExpect[4].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('equirectangular', 'Equirectangular')
      TDClass.add_standardParallel(hProjection, 1)
      TDClass.add_longCM(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:standardParallel1] = nil
      hProjection[:longitudeOfCentralMeridian] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:standardParallel1)
      hProjection.delete(:longitudeOfCentralMeridian)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection equirectangular'

   end

   # map projections - general vertical near-side perspective
   def test_mapProjection_generalVertical

      expect = @@axExpect[5].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('generalVertical', 'General Vertical Near-sided Perspective')
      TDClass.add_heightPP(hProjection)
      TDClass.add_longPC(hProjection)
      TDClass.add_latPC(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:heightOfProspectivePointAboveSurface] = nil
      hProjection[:longitudeOfProjectionCenter] = nil
      hProjection[:latitudeOfProjectionCenter] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection height of perspective point above surface is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:heightOfProspectivePointAboveSurface)
      hProjection.delete(:longitudeOfProjectionCenter)
      hProjection.delete(:latitudeOfProjectionCenter)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection height of perspective point above surface is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection generalVertical'

   end

   # map projections - gnomonic perspective
   def test_mapProjection_gnomonic

      expect = @@axExpect[6].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('gnomonic', 'Gnomonic')
      TDClass.add_longPC(hProjection)
      TDClass.add_latPC(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:longitudeOfProjectionCenter] = nil
      hProjection[:latitudeOfProjectionCenter] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:longitudeOfProjectionCenter)
      hProjection.delete(:latitudeOfProjectionCenter)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection gnomonic'

   end

   # map projections - lambert azimuthal equal area
   def test_mapProjection_lambertEqualArea

      expect = @@axExpect[7].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('lambertEqualArea', 'Lambert Azimuthal Equal Area')
      TDClass.add_longPC(hProjection)
      TDClass.add_latPC(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:longitudeOfProjectionCenter] = nil
      hProjection[:latitudeOfProjectionCenter] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:longitudeOfProjectionCenter)
      hProjection.delete(:latitudeOfProjectionCenter)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection lambertEqualArea'

   end

   # map projections - lambert conformal conic
   def test_mapProjection_lambertConic

      expect = @@axExpect[8].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('lambertConic', 'Lambert Conformal Conic')
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

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:standardParallel1] = nil
      hProjection[:standardParallel2] = nil
      hProjection[:longitudeOfCentralMeridian] = nil
      hProjection[:latitudeOfProjectionOrigin] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:standardParallel1)
      hProjection.delete(:standardParallel2)
      hProjection.delete(:longitudeOfCentralMeridian)
      hProjection.delete(:latitudeOfProjectionOrigin)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length

      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection lambertConic'

   end

   # map projections - mercator (standard parallel)
   def test_mapProjection_mercatorSP

      expect = @@axExpect[9].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('mercator', 'Mercator')
      TDClass.add_standardParallel(hProjection, 1)
      TDClass.add_longCM(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:standardParallel1] = nil
      hProjection[:longitudeOfCentralMeridian] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection mercator'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:standardParallel1)
      hProjection.delete(:longitudeOfCentralMeridian)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length

      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection mercator'

   end

   # def test_mapProjection_elements_mercator_SF
   def test_mapProjection_mercatorSF

      expect = @@axExpect[10].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('mercator', 'Mercator')
      TDClass.add_scaleFactorE(hProjection)
      TDClass.add_longCM(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:scaleFactorAtEquator] = nil
      hProjection[:longitudeOfCentralMeridian] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection mercator'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:scaleFactorAtEquator)
      hProjection.delete(:longitudeOfCentralMeridian)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length

      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection mercator'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection mercator'

   end

   # map projections - miller cylindrical
   def test_mapProjection_miller

      expect = @@axExpect[11].to_s.squeeze(' ')

      hProjection = TDClass.build_projection('miller', 'Miller Cylindrical')
      TDClass.add_longCM(hProjection)
      TDClass.add_falseNE(hProjection)

      hResponseObj = get_response(hProjection)

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(@@path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

      # test empty elements
      hProjection[:falseNorthing] = nil
      hProjection[:falseEasting] = nil
      hProjection[:longitudeOfCentralMeridian] = nil

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection miller'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection miller'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection miller'

      # test missing elements
      hProjection.delete(:falseNorthing)
      hProjection.delete(:falseEasting)
      hProjection.delete(:longitudeOfCentralMeridian)

      hResponseObj = get_response(hProjection)

      refute hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is spatial reference horizontal planar map projection miller'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is spatial reference horizontal planar map projection miller'
      assert_includes hResponseObj[:writerMessages], 'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is spatial reference horizontal planar map projection miller'

   end





  
   # # map projections - oblique mercator (line azimuth)
   # def test_mapProjection_obliqueMercatorLA
   #
   #    expect = @@axExpect[12].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'obliqueMercator')
   #    TDClass.add_scaleFactorCL(hSpaceRef)
   #    TDClass.add_obliqueLineAzimuth(hSpaceRef)
   #    TDClass.add_latPO(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # # map projections - oblique mercator (line point)
   # def test_mapProjection_obliqueMercatorLP
   #
   #    expect = @@axExpect[13].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'obliqueMercator')
   #    TDClass.add_scaleFactorCL(hSpaceRef)
   #    TDClass.add_obliqueLinePoint(hSpaceRef)
   #    TDClass.add_obliqueLinePoint(hSpaceRef)
   #    TDClass.add_latPO(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_obliqueMercatorLA_LP
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'obliqueMercator')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 6, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection scale factor at center line is missing: CONTEXT is Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection oblique line azimuth information is missing: CONTEXT is Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - orthographic
   # def test_mapProjection_orthographic
   #
   #    expect = @@axExpect[14].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'orthographic')
   #    TDClass.add_longPC(hSpaceRef)
   #    TDClass.add_latPC(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_orthographic
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'orthographic')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 5, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Orthographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is Orthographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Orthographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Orthographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - polar stereographic (standard parallel)
   # def test_mapProjection_polarStereographicSP
   #
   #    expect = @@axExpect[15].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'polarStereo')
   #    TDClass.add_straightFromPole(hSpaceRef)
   #    TDClass.add_standardParallel(hSpaceRef, 1)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # # map projections - polar stereographic (scale factor)
   # def test_mapProjection_polarStereographicSF
   #
   #    expect = @@axExpect[16].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'polarStereo')
   #    TDClass.add_straightFromPole(hSpaceRef)
   #    TDClass.add_scaleFactorPO(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_polarStereographicSP_SF
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'polarStereo')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 4, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection straight vertical longitude from pole is missing: CONTEXT is Polar Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Polar Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Polar Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - polyconic
   # def test_mapProjection_polyconic
   #
   #    expect = @@axExpect[17].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'polyconic')
   #    TDClass.add_longCM(hSpaceRef)
   #    TDClass.add_latPO(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_polyconic
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'polyconic')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 5, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Polyconic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Polyconic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Polyconic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Polyconic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - robinson
   # def test_mapProjection_robinson
   #
   #    expect = @@axExpect[18].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'robinson')
   #    TDClass.add_longPC(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_robinson
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'robinson')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 4, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Robinson projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Robinson projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Robinson projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - sinusoidal
   # def test_mapProjection_sinusoidal
   #
   #    expect = @@axExpect[19].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'sinusoidal')
   #    TDClass.add_longCM(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_sinusoidal
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'sinusoidal')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 4, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Sinusoidal projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Sinusoidal projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Sinusoidal projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - space oblique
   # def test_mapProjection_spaceOblique
   #
   #    expect = @@axExpect[20].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'spaceOblique')
   #    TDClass.add_landsat(hSpaceRef)
   #    TDClass.add_landsatPath(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_spaceOblique
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'spaceOblique')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 5, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection landsat number is missing: CONTEXT is Space Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection landsat path is missing: CONTEXT is Space Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Space Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Space Oblique Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - stereographic
   # def test_mapProjection_stereographic
   #
   #    expect = @@axExpect[21].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'stereographic')
   #    TDClass.add_longPC(hSpaceRef)
   #    TDClass.add_latPC(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_stereographic
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'stereographic')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 5, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Stereographic projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - transverse mercator
   # def test_mapProjection_transverseMercator
   #
   #    expect = @@axExpect[22].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'transverseMercator')
   #    TDClass.add_scaleFactorCM(hSpaceRef)
   #    TDClass.add_longCM(hSpaceRef)
   #    TDClass.add_latPO(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   #
   # def test_mapProjection_elements_transverseMercator
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'transverseMercator')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 6, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection scale factor at central meridian is missing: CONTEXT is Transverse Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Transverse Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Transverse Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Transverse Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Transverse Mercator projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - van der grinten
   # def test_mapProjection_vanDerGrinten
   #
   #    expect = @@axExpect[23].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'grinten')
   #    TDClass.add_longCM(hSpaceRef)
   #    TDClass.add_falseNE(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end
   # def test_mapProjection_elements_vanDerGrinten
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'grinten')
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    hResponseObj = ADIWG::Mdtranslator.translate(
   #       file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
   #    )
   #
   #    refute hResponseObj[:writerPass]
   #    assert_equal 4, hResponseObj[:writerMessages].length
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Van der Grinten projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Van der Grinten projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Van der Grinten projection'
   #    assert_includes hResponseObj[:writerMessages],
   #                    'ERROR: FGDC writer: planar coordinate information section is missing'
   #
   # end
   #
   # # map projections - projection parameters
   # def test_mapProjection_projectionParameters
   #
   #    expect = @@axExpect[24].to_s.squeeze(' ')
   #
   #    mdHash = TDClass.base
   #    hSpaceRef = TDClass.spatialReferenceSystem
   #    TDClass.add_projection(hSpaceRef, 'parameters')
   #    TDClass.add_falseNE(hSpaceRef)
   #    TDClass.add_standardParallel(hSpaceRef, 2)
   #    TDClass.add_longCM(hSpaceRef)
   #    TDClass.add_latPO(hSpaceRef)
   #    TDClass.add_heightPP(hSpaceRef)
   #    TDClass.add_longPC(hSpaceRef)
   #    TDClass.add_latPC(hSpaceRef)
   #    TDClass.add_scaleFactorE(hSpaceRef)
   #    TDClass.add_scaleFactorCL(hSpaceRef)
   #    TDClass.add_scaleFactorPO(hSpaceRef)
   #    TDClass.add_scaleFactorCM(hSpaceRef)
   #    TDClass.add_obliqueLineAzimuth(hSpaceRef)
   #    TDClass.add_obliqueLinePoint(hSpaceRef)
   #    TDClass.add_obliqueLinePoint(hSpaceRef)
   #    TDClass.add_straightFromPole(hSpaceRef)
   #    TDClass.add_landsat(hSpaceRef)
   #    TDClass.add_landsatPath(hSpaceRef)
   #    TDClass.add_otherProjection(hSpaceRef)
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
   #    mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef
   #
   #    run_test(mdHash, @@path, expect)
   #
   # end

end
