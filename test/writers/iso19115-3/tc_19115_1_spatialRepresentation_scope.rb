# MdTranslator - minitest of
# writers / iso19115_1 / class_spatialRepresentation_scope

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151SpatialRepresentationScope < TestWriter191151Parent

  # instance classes needed in script
  TDClass = MdJsonHashWriter.new

  # build mdJson test file in hash
  mdHash = TDClass.base

  mdHash[:metadata][:resourceInfo][:spatialRepresentation] = TDClass.build_spatialRepresentation_with_scope

  @@mdHash = mdHash



  def test_spatialRepresentation_grid_scope
    hIn = Marshal::load(Marshal.dump(@@mdHash))

    hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_spatialRepresentation_scope', 
                                              '//mdb:spatialRepresentationInfo[1]', 
                                              '//mdb:spatialRepresentationInfo', 0)

    assert_equal hReturn[0], hReturn[1]
  end
end
