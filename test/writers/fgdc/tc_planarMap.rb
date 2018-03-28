# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-03 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapProjection < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # read the fgdc reference file
   @@path = './metadata/spref/horizsys/planar/mapproj'
   xFile = TestWriterFGDCParent.get_xml('mapProjection')
   @@axExpect = xFile.xpath(@@path)

   def run_test(mdHash, path, expect)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - alaska
   def test_mapProjection_alaska

      expect = @@axExpect[0].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'alaska')
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_alaska

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'alaska')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 3, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Modified Stereographic for Alaska projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Modified Stereographic for Alaska projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - albers
   def test_mapProjection_albers

      expect = @@axExpect[1].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'albers')
      TDClass.add_standardParallel(hSpaceRef, 2)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_albers

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'albers')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 6, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is Albers Conical Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Albers Conical Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Albers Conical Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Albers Conical Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Albers Conical Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - azimuthal equidistant
   def test_mapProjection_azimuthalEquidistant

      expect = @@axExpect[2].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'azimuthalEquidistant')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_azimuthalEquidistant

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'azimuthalEquidistant')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Azimuthal Equidistant projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Azimuthal Equidistant projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Azimuthal Equidistant projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Azimuthal Equidistant projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - equidistant conic
   def test_mapProjection_equidistantConic

      expect = @@axExpect[3].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'equidistantConic')
      TDClass.add_standardParallel(hSpaceRef, 2)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_equidistantConic

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'equidistantConic')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 6, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is Equidistant Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Equidistant Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Equidistant Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Equidistant Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Equidistant Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - equirectangular
   def test_mapProjection_equirectangular

      expect = @@axExpect[4].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'equirectangular')
      TDClass.add_standardParallel(hSpaceRef)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_equirectangular

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'equirectangular')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is Equirectangular projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Equirectangular projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Equirectangular projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Equirectangular projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - general vertical near-side perspective
   def test_mapProjection_generalVertical

      expect = @@axExpect[5].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'generalVertical')
      TDClass.add_heightPP(hSpaceRef)
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_latPC(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_generalVertical

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'generalVertical')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 6, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection height of perspective point above surface is missing: CONTEXT is General Vertical Near-sided Perspective projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is General Vertical Near-sided Perspective projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is General Vertical Near-sided Perspective projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is General Vertical Near-sided Perspective projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is General Vertical Near-sided Perspective projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - gnomonic
   def test_mapProjection_gnomonic

      expect = @@axExpect[6].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'gnomonic')
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_latPC(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_gnomonic

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'gnomonic')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Gnomonic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is Gnomonic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Gnomonic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Gnomonic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - lambert azimuthal equal area
   def test_mapProjection_lambertAzimuthal

      expect = @@axExpect[7].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'lambertEqualArea')
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_latPC(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_lambertAzimuthal

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'lambertEqualArea')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Lambert Azimuthal Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is Lambert Azimuthal Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Lambert Azimuthal Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Lambert Azimuthal Equal Area projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - lambert conformal conic
   def test_mapProjection_lambertConformal

      expect = @@axExpect[8].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'lambertConic')
      TDClass.add_standardParallel(hSpaceRef, 2)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_lambertConic

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'lambertConic')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 6, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection standard parallel is missing: CONTEXT is Lambert Conformal Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Lambert Conformal Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Lambert Conformal Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Lambert Conformal Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Lambert Conformal Conic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - mercator (standard parallel)
   def test_mapProjection_mercatorSP

      expect = @@axExpect[9].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'mercator')
      TDClass.add_standardParallel(hSpaceRef, 1)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - mercator (scale factor)
   def test_mapProjection_mercatorSF

      expect = @@axExpect[10].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'mercator')
      TDClass.add_scaleFactorE(hSpaceRef)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_mercator_SF

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'mercator')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - miller cylindrical
   def test_mapProjection_miller

      expect = @@axExpect[11].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'miller')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_miller

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'miller')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Miller Cylindrical projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Miller Cylindrical projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Miller Cylindrical projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - oblique mercator (line azimuth)
   def test_mapProjection_obliqueMercatorLA

      expect = @@axExpect[12].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'obliqueMercator')
      TDClass.add_scaleFactorCL(hSpaceRef)
      TDClass.add_obliqueLineAzimuth(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - oblique mercator (line point)
   def test_mapProjection_obliqueMercatorLP

      expect = @@axExpect[13].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'obliqueMercator')
      TDClass.add_scaleFactorCL(hSpaceRef)
      TDClass.add_obliqueLinePoint(hSpaceRef)
      TDClass.add_obliqueLinePoint(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_obliqueMercatorLA_LP

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'obliqueMercator')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 6, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection scale factor at center line is missing: CONTEXT is Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection oblique line azimuth information is missing: CONTEXT is Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - orthographic
   def test_mapProjection_orthographic

      expect = @@axExpect[14].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'orthographic')
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_latPC(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_orthographic

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'orthographic')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Orthographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is Orthographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Orthographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Orthographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - polar stereographic (standard parallel)
   def test_mapProjection_polarStereographicSP

      expect = @@axExpect[15].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polarStereo')
      TDClass.add_straightFromPole(hSpaceRef)
      TDClass.add_standardParallel(hSpaceRef, 1)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - polar stereographic (scale factor)
   def test_mapProjection_polarStereographicSF

      expect = @@axExpect[16].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polarStereo')
      TDClass.add_straightFromPole(hSpaceRef)
      TDClass.add_scaleFactorPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_polarStereographicSP_SF

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polarStereo')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection straight vertical longitude from pole is missing: CONTEXT is Polar Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Polar Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Polar Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - polyconic
   def test_mapProjection_polyconic

      expect = @@axExpect[17].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polyconic')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_polyconic

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polyconic')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Polyconic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Polyconic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Polyconic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Polyconic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - robinson
   def test_mapProjection_robinson

      expect = @@axExpect[18].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'robinson')
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_robinson

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'robinson')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Robinson projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Robinson projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Robinson projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - sinusoidal
   def test_mapProjection_sinusoidal

      expect = @@axExpect[19].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'sinusoidal')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_sinusoidal

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'sinusoidal')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Sinusoidal projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Sinusoidal projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Sinusoidal projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - space oblique
   def test_mapProjection_spaceOblique

      expect = @@axExpect[20].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'spaceOblique')
      TDClass.add_landsat(hSpaceRef)
      TDClass.add_landsatPath(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_spaceOblique

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'spaceOblique')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection landsat number is missing: CONTEXT is Space Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection landsat path is missing: CONTEXT is Space Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Space Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Space Oblique Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - stereographic
   def test_mapProjection_stereographic

      expect = @@axExpect[21].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'stereographic')
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_latPC(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_stereographic

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'stereographic')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 5, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of projection center is missing: CONTEXT is Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection center is missing: CONTEXT is Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Stereographic projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - transverse mercator
   def test_mapProjection_transverseMercator

      expect = @@axExpect[22].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'transverseMercator')
      TDClass.add_scaleFactorCM(hSpaceRef)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   def test_mapProjection_elements_transverseMercator

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'transverseMercator')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 6, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection scale factor at central meridian is missing: CONTEXT is Transverse Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Transverse Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection latitude of projection origin is missing: CONTEXT is Transverse Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Transverse Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Transverse Mercator projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - van der grinten
   def test_mapProjection_vanDerGrinten

      expect = @@axExpect[23].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'grinten')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end
   def test_mapProjection_elements_vanDerGrinten

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'grinten')
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute hResponseObj[:writerPass]
      assert_equal 4, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection longitude of central meridian is missing: CONTEXT is Van der Grinten projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false easting is missing: CONTEXT is Van der Grinten projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: map projection false northing is missing: CONTEXT is Van der Grinten projection'
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: planar coordinate information section is missing'

   end

   # map projections - projection parameters
   def test_mapProjection_projectionParameters

      expect = @@axExpect[24].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'parameters')
      TDClass.add_falseNE(hSpaceRef)
      TDClass.add_standardParallel(hSpaceRef, 2)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_heightPP(hSpaceRef)
      TDClass.add_longPC(hSpaceRef)
      TDClass.add_latPC(hSpaceRef)
      TDClass.add_scaleFactorE(hSpaceRef)
      TDClass.add_scaleFactorCL(hSpaceRef)
      TDClass.add_scaleFactorPO(hSpaceRef)
      TDClass.add_scaleFactorCM(hSpaceRef)
      TDClass.add_obliqueLineAzimuth(hSpaceRef)
      TDClass.add_obliqueLinePoint(hSpaceRef)
      TDClass.add_obliqueLinePoint(hSpaceRef)
      TDClass.add_straightFromPole(hSpaceRef)
      TDClass.add_landsat(hSpaceRef)
      TDClass.add_landsatPath(hSpaceRef)
      TDClass.add_otherProjection(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

end
