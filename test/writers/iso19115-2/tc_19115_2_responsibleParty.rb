# MdTranslator - minitest of
# writers / iso19115_2 / class_responsibleParty

# History:
#  Stan Smith 2018-04-30 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2016-11-21 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152ResponsibleParty < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_responsible_party_individual

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_responsibleParty',
                                                '//gmd:contact[1]',
                                                '//gmd:contact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_responsible_party_organization

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:metadataInfo][:metadataContact][0][:party] << { contactId: 'CID002' }

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_responsibleParty',
                                                '//gmd:contact[2]',
                                                '//gmd:contact', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_responsible_party_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hContact1 = TDClass.build_responsibleParty('role one', %w(CID003))
      hIn[:metadata][:metadataInfo][:metadataContact] = []
      hIn[:metadata][:metadataInfo][:metadataContact] << hContact1

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_responsibleParty',
                                                '//gmd:contact[3]',
                                                '//gmd:contact', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_responsible_party_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hContact1 = TDClass.build_responsibleParty('role one', %w(CID003))
      hContact2 = TDClass.build_responsibleParty('role two', %w(CID004))
      hIn[:metadata][:metadataInfo][:metadataContact] = []
      hIn[:metadata][:metadataInfo][:metadataContact] << hContact1
      hIn[:metadata][:metadataInfo][:metadataContact] << hContact2

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_responsibleParty',
                                                '//gmd:contact[4]',
                                                '//gmd:contact', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
