# MdTranslator - minitest of
# writers / fgdc / class_constraint

# History:
#  Stan Smith 2017-12-14 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcConstraint < TestReaderFgdcParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   # constraint is in base
   mdHash = TDClass.base
   @@mdHash = mdHash

   def test_accessConstraint_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'constraint', './metadata/idinfo/accconst')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_useConstraint_complete

      hReturn = TestReaderFgdcParent.get_complete(@@mdHash, 'constraint', './metadata/idinfo/useconst')
      assert_equal hReturn[0], hReturn[1]

   end

end
