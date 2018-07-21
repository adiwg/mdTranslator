# MdTranslator - minitest of
# reader / mdJson / module_party

# History:
#  Stan Smith 2018-06-22 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_party'

class TestReaderMdJsonParty < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Party

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = []
   mdHash << {contactId: 'CID001'}
   mdHash << {contactId: 'CID002', organizationMembers: %w(CID001 CID003)}
   mdHash << {contactId: 'CID006'}
   mdHash << {contactId: 'CID002', organizationMembers: %w(CID007)}

   @@mdHash = mdHash

   def test_party_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash[1], 'responsibility.json', :fragment => 'party')
      assert_empty errors

   end

   def test_individual_party_complete

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[0]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'CID001', metadata[:contactId]
      assert_equal 0, metadata[:contactIndex]
      assert_equal 'individual', metadata[:contactType]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_organization_party_complete

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'CID002', metadata[:contactId]
      assert_equal 1, metadata[:contactIndex]
      assert_equal 'organization', metadata[:contactType]
      assert_equal 2, metadata[:organizationMembers].length
      assert_equal 'CID001', metadata[:organizationMembers][0]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_party_id

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hIn['contactId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: party contact ID is missing: CONTEXT is testing'

   end

   def test_missing_party_id

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[1]))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('contactId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: party contact ID is missing: CONTEXT is testing'
   end

   def test_bad_party_id

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[2]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: party contact not in contacts list: CONTEXT is testing > contact ID CID006'
   end

   def test_bad_organizationMember_id

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash[3]))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      assert_equal 1, metadata[:organizationMembers].length
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'WARNING: mdJson reader: party organization member contact not in contacts list: CONTEXT is testing > contact ID CID007'
   end

   def test_empty_party

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: party object is empty: CONTEXT is testing'
   end

end
