# MdTranslator - minitest of
# writers / iso19115_3 / class_gridRepresentation

# History:
#  Stan Smith 2019-04-19 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151GridRepresentation < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hGrid = TDClass.build_gridRepresentation()
   hSpaceRep = TDClass.build_spatialRepresentation('grid', hGrid)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << hSpaceRep

   @@mdHash = mdHash

   def test_gridRepresentation_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_gridRepresentation',
                                                '//mdb:spatialRepresentationInfo[1]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_gridRepresentation_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # empty elements
      # only optional element is Boolean which defaults to FALSE

      # missing elements
      hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:gridRepresentation].delete(:transformationParameterAvailable)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_gridRepresentation',
                                                '//mdb:spatialRepresentationInfo[1]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
