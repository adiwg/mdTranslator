# MdTranslator - minitest of
# writers / iso19110 / class_contact

# History:
#  Stan Smith 2018-04-02 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-23 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110Contact < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary 1
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_contact_individual_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:hoursOfService] = []
      hIn[:contact][0][:hoursOfService] << 'hours of service'
      hIn[:contact][0][:contactInstructions] = 'contact instructions'
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_contact',
                                                   '//gmd:contactInfo[1]', '//gmd:contactInfo')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_contact_organization_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:isOrganization] = true
      hIn[:contact][0][:hoursOfService] = []
      hIn[:contact][0][:hoursOfService] << 'hours of service'
      hIn[:contact][0][:contactInstructions] = 'contact instructions'
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_contact',
                                                   '//gmd:contactInfo[1]', '//gmd:contactInfo')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_contact_multi_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []
      hIn[:contact][0][:hoursOfService] = []
      hIn[:contact][0][:hoursOfService] << 'hours of service'
      hIn[:contact][0][:hoursOfService] << 'hours of service 2'
      hIn[:contact][0][:contactInstructions] = 'contact instructions'

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_contact',
                                                   '//gmd:contactInfo[1]', '//gmd:contactInfo')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_contact_empty_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []
      hIn[:contact][0][:electronicMailAddress] = []
      hIn[:contact][0][:onlineResource] = []
      hIn[:contact][0][:hoursOfService] = []
      hIn[:contact][0][:contactInstructions] = ''

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_contact',
                                                   '//gmd:contactInfo[3]', '//gmd:contactInfo')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_contact_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0].delete(:phone)
      hIn[:contact][0].delete(:address)
      hIn[:contact][0].delete(:onlineResource)
      hIn[:contact][0].delete(:hoursOfService)
      hIn[:contact][0].delete(:contactInstructions)

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_contact',
                                                   '//gmd:contactInfo[3]', '//gmd:contactInfo')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
