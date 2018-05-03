# MdTranslator - minitest of
# writers / iso19110 / class_responsibleParty

# History:
#  Stan Smith 2018-04-03 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-01-23 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110ResponsibleParty < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary 1
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   @@mdHash = mdHash

   def test_responsibleParty_individual

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_responsibleParty',
                                                   '//gfc:producer[1]', '//gfc:producer')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_responsibleParty_organization

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:isOrganization] = true
      hIn[:contact][0][:name] = 'organization name'
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_responsibleParty',
                                                   '//gfc:producer[2]', '//gfc:producer')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_responsibleParty_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:positionName] = ''
      hIn[:contact][0][:phone] = []
      hIn[:contact][0][:address] = []

      hReturn = TestWriter19110Parent.run_test(hIn, '19110_responsibleParty',
                                                   '//gfc:producer[3]', '//gfc:producer')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
