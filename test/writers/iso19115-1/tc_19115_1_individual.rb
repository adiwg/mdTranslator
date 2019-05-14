# MdTranslator - minitest of
# writers / iso19115_1 / class_individual

# History:
#  Stan Smith 2019-05-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Individual < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_individual_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_individual',
                                                '//cit:party[1]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_individual_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hContact = hIn[:contact][2]
      hParty = hIn[:metadata][:metadataInfo][:metadataContact][0][:party][0]
      hParty[:contactId] = 'CID003'

      # missing positionName
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_individual',
                                                '//cit:party[2]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing name
      hContact.delete(:name)
      hContact[:positionName] = 'positionName'
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_individual',
                                                '//cit:party[3]',
                                                '//cit:party', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end



end
