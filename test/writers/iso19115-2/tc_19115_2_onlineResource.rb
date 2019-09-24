# MdTranslator - minitest of
# writers / iso19115_2 / class_onlineResource

# History:
#  Stan Smith 2018-04-26 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2016-11-21 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152OnlineResource < TestWriter191152Parent

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

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_onlineResource',
                                                '//gmd:onlineResource[1]',
                                                '//gmd:onlineResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_onlineResource_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOLRes = hIn[:contact][2][:onlineResource][0]
      hOLRes.delete(:name)
      hOLRes.delete(:description)
      hOLRes.delete(:function)
      hOLRes.delete(:protocol)
      hOLRes.delete(:applicationProfile)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_onlineResource',
                                                '//gmd:onlineResource[2]',
                                                '//gmd:onlineResource', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
