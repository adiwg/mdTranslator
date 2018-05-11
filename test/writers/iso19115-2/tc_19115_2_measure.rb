# MdTranslator - minitest of
# writers / iso19115_2 / class_measure

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-11-19 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Measure < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGrid = TDClass.build_gridRepresentation()
   TDClass.add_dimension(hGrid)
   hSpaceRep = TDClass.build_spatialRepresentation('grid', hGrid)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   def test_measure_distance

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_measure',
                                                '//gmd:resolution[1]',
                                                '//gmd:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_measure_length

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMeasure = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation][:dimension][0][:resolution]
      hMeasure[:type] = 'length'
      hMeasure[:unitOfMeasure] = 'lengthuom'

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_measure',
                                                '//gmd:resolution[2]',
                                                '//gmd:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_measure_angle

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMeasure = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation][:dimension][0][:resolution]
      hMeasure[:type] = 'angle'
      hMeasure[:unitOfMeasure] = 'angleuom'

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_measure',
                                                '//gmd:resolution[3]',
                                                '//gmd:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_measure_measure

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMeasure = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation][:dimension][0][:resolution]
      hMeasure[:type] = 'measure'
      hMeasure[:unitOfMeasure] = 'measureuom'

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_measure',
                                                '//gmd:resolution[4]',
                                                '//gmd:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_measure_scale

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hMeasure = hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation][:dimension][0][:resolution]
      hMeasure[:type] = 'scale'
      hMeasure[:unitOfMeasure] = 'scaleuom'

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_measure',
                                                '//gmd:resolution[5]',
                                                '//gmd:resolution', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
