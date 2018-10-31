# MdTranslator - minitest of
# writers / iso19115_2 / class_mdIdentifier

# History:
#  Stan Smith 2018-04-25 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2017-01-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152MDIdentifier < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:citation][:identifier] = []
   mdHash[:metadata][:resourceInfo][:citation][:identifier] << TDClass.build_identifier('citation identifier one')

   @@mdHash = mdHash

   def test_identifier_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_mdIdentifier',
                                                '//gmd:MD_Identifier[1]',
                                                '//gmd:MD_Identifier', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
