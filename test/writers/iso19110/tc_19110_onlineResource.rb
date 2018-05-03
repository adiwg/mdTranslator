# MdTranslator - minitest of
# writers / iso19110 / class_onlineResource

# History:
#  Stan Smith 2018-04-02 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-01 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110OnlineResource < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary 1
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_onlineResource_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOLRes1 = TDClass.build_onlineResource('http://adiwg/uri/1')
      hIn[:contact][0][:onlineResource] = []
      hIn[:contact][0][:onlineResource] << hOLRes1

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_onlineResource',
                                                   '//gmd:onlineResource[1]', '//gmd:onlineResource')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_onlineResource_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOLRes1 = TDClass.build_onlineResource('http://adiwg/uri/1')
      hOLRes2 = TDClass.build_onlineResource('http://adiwg/uri/2')
      hIn[:contact][0][:onlineResource] = []
      hIn[:contact][0][:onlineResource] << hOLRes1
      hIn[:contact][0][:onlineResource] << hOLRes2

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_onlineResource',
                                                   '//gmd:onlineResource[1]', '//gmd:onlineResource')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_onlineResource_empty_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOLRes1 = TDClass.build_onlineResource('http://adiwg/uri/1')
      hOLRes1[:name] = ''
      hOLRes1[:protocol] = ''
      hOLRes1[:description] = ''
      hOLRes1[:function] = ''
      hIn[:contact][0][:onlineResource] = []
      hIn[:contact][0][:onlineResource] << hOLRes1

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_onlineResource',
                                                   '//gmd:onlineResource[2]', '//gmd:onlineResource')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_onlineResource_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hOLRes1 = TDClass.build_onlineResource('http://adiwg/uri/1')
      hOLRes1.delete(:name)
      hOLRes1.delete(:protocol)
      hOLRes1.delete(:description)
      hOLRes1.delete(:function)
      hIn[:contact][0][:onlineResource] = []
      hIn[:contact][0][:onlineResource] << hOLRes1

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_onlineResource',
                                                   '//gmd:onlineResource[2]', '//gmd:onlineResource')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
