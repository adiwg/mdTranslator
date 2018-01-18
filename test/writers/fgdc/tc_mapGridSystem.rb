# MdTranslator - minitest of
# writers / fgdc / class_spatialReference

# History:
#  Stan Smith 2018-01-08 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcMapGridSystem < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # read the fgdc reference file
   @@path = './metadata/spref/horizsys/planar/gridsys'
   xFile = TestReaderFgdcParent.get_xml('mapGridSystem')
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

   # map projections - utm
   def test_mapGrid_utm

      expect = @@axExpect[0].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'transverseMercator')
      TDClass.add_grid(hSpaceRef, 'utm',nil, '9')
      TDClass.add_scaleFactorCM(hSpaceRef)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - ups (standard parallel)
   def test_mapGrid_upsSP

      expect = @@axExpect[1].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polarStereo')
      TDClass.add_grid(hSpaceRef, 'ups',nil,'B')
      TDClass.add_straightFromPole(hSpaceRef)
      TDClass.add_standardParallel(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - ups (scale factor)
   def test_mapGrid_upsSF

      expect = @@axExpect[2].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polarStereo')
      TDClass.add_grid(hSpaceRef, 'ups',nil,'B')
      TDClass.add_straightFromPole(hSpaceRef)
      TDClass.add_scaleFactorPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - state plane coordinate system (lambert conformal conic)
   def test_mapGrid_spcs_lambert

      expect = @@axExpect[3].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'lambertConic')
      TDClass.add_grid(hSpaceRef, 'spcs','Alaska State Plane Coordinate System', '9')
      TDClass.add_standardParallel(hSpaceRef, 2)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - state plane coordinate system (transverse mercator)
   def test_mapGrid_spcs_transMercator

      expect = @@axExpect[4].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'transverseMercator')
      TDClass.add_grid(hSpaceRef, 'spcs','Alaska State Plane Coordinate System', '8')
      TDClass.add_scaleFactorCM(hSpaceRef)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - state plane coordinate system (oblique mercator - line azimuth)
   def test_mapGrid_spcs_obliqueMercatorLA

      expect = @@axExpect[5].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'obliqueMercator')
      TDClass.add_grid(hSpaceRef, 'spcs','Alaska State Plane Coordinate System', '7')
      TDClass.add_scaleFactorCL(hSpaceRef)
      TDClass.add_obliqueLineAzimuth(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - state plane coordinate system (oblique mercator - line point)
   def test_mapGrid_spcs_obliqueMercatorLP

      expect = @@axExpect[6].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'obliqueMercator')
      TDClass.add_grid(hSpaceRef, 'spcs','Alaska State Plane Coordinate System', '6')
      TDClass.add_scaleFactorCL(hSpaceRef)
      TDClass.add_obliqueLinePoint(hSpaceRef)
      TDClass.add_obliqueLinePoint(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - state plane coordinate system (polyconic)
   def test_mapGrid_spcs_polyconic

      expect = @@axExpect[7].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'polyconic')
      TDClass.add_grid(hSpaceRef, 'spcs','Alaska State Plane Coordinate System', '5')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - equal arc-second coordinate system (equirectangular)
   def test_mapGrid_arcsys_equirectangular

      expect = @@axExpect[8].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'equirectangular')
      TDClass.add_grid(hSpaceRef, 'arcsys','equal arc-second coordinate system', '10')
      TDClass.add_standardParallel(hSpaceRef, 1)
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

   # map projections - equal arc-second coordinate system (azimuthal equidistant)
   def test_mapGrid_arcsys_azimuthalEquidistant

      expect = @@axExpect[9].to_s.squeeze(' ')

      mdHash = TDClass.base
      hSpaceRef = TDClass.spatialReferenceSystem
      TDClass.add_projection(hSpaceRef, 'azimuthalEquidistant')
      TDClass.add_grid(hSpaceRef, 'arcsys','equal arc-second coordinate system', '10')
      TDClass.add_longCM(hSpaceRef)
      TDClass.add_latPO(hSpaceRef)
      TDClass.add_falseNE(hSpaceRef)
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] = []
      mdHash[:metadata][:resourceInfo][:spatialReferenceSystem] << hSpaceRef

      run_test(mdHash, @@path, expect)

   end

end
