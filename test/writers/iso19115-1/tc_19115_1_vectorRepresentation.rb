# MdTranslator - minitest of
# writers / iso19115_1 / class_vectorRepresentation

# History:
#  Stan Smith 2019-05-15 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151VectorRepresentation < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hSpaceRef = TDClass.build_vectorRepresentation('level one')
   TDClass.add_vectorObject(hSpaceRef,'type one', 1)
   TDClass.add_vectorObject(hSpaceRef,'type two', 2)
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] = []
   mdHash[:metadata][:resourceInfo][:spatialRepresentation] << { vectorRepresentation: hSpaceRef }

   @@mdHash = mdHash

   def test_vectorRepresentation_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_vectorRepresentation',
                                                '//mdb:spatialRepresentationInfo[1]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_vectorRepresentation_level

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:vectorRepresentation].delete(:vectorObject)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_vectorRepresentation',
                                                '//mdb:spatialRepresentationInfo[2]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_vectorRepresentation_objects

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:spatialRepresentation][0][:vectorRepresentation].delete(:topologyLevel)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_vectorRepresentation',
                                                '//mdb:spatialRepresentationInfo[3]',
                                                '//mdb:spatialRepresentationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
