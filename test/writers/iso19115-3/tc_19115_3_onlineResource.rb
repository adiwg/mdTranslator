# MdTranslator - minitest of
# writers / iso19115_3 / class_onlineResource

# History:
#  Stan Smith 2019-05-09 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151OnlineResource < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:metadataInfo][:metadataContact][0][:party][0] = { contactId: 'CID003' }
   mdHash[:contact][2][:onlineResource] = []
   mdHash[:contact][2][:onlineResource] << TDClass.build_onlineResource('http://online.adiwg.org/1')

   @@mdHash = mdHash

   def test_onlineResource_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_onlineResource',
                                                '//cit:onlineResource[1]',
                                                '//cit:onlineResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_onlineResource_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOLRes = hIn[:contact][2][:onlineResource][0]

      # empty elements
      hOLRes[:name] = ''
      hOLRes[:description] = ''
      hOLRes[:function] = ''
      hOLRes[:applicationProfile] = ''
      hOLRes[:protocol] = ''
      hOLRes[:protocolRequest] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_onlineResource',
                                                '//cit:onlineResource[2]',
                                                '//cit:onlineResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hOLRes.delete(:name)
      hOLRes.delete(:description)
      hOLRes.delete(:function)
      hOLRes.delete(:applicationProfile)
      hOLRes.delete(:protocol)
      hOLRes.delete(:protocolRequest)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_onlineResource',
                                                '//cit:onlineResource[2]',
                                                '//cit:onlineResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
