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

      # TODO validate 'normal' after schema update
      hResponseObj = ADIWG::Mdtranslator.translate(
         file: mdHash.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      xMetadata = Nokogiri::XML(hResponseObj[:writerOutput])
      xGot = xMetadata.xpath(path)
      got = xGot.to_s.squeeze(' ')

      assert_equal expect, got
      assert hResponseObj[:writerPass]
      assert_empty hResponseObj[:writerMessages]

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
