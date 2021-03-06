# MdTranslator - minitest of
# writers / iso19115_2 / class_useConstraint

# History:
#  Stan Smith 2018-05-03 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152UseConstraint < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:constraint] << TDClass.build_useConstraint

   @@mdHash = mdHash

   def test_useConstraint_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_useConstraint',
                                                '//gmd:resourceConstraints[1]',
                                                '//gmd:resourceConstraints', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
