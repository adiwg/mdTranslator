# MdTranslator - minitest of
# reader / mdJson / module_party

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-09 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_party'

class TestReaderMdJsonParty < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Party
   aIn = TestReaderMdJsonParent.getJson('party.json')
   @@aIn = aIn['party']
   @@hIn = @@aIn[1]

   def test_party_schema

      errors = TestReaderMdJsonParent.testSchema(@@hIn, 'responsibility.json', :fragment => 'party')
      assert_empty errors

   end

   def test_individual_party_complete

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@aIn[0]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'individualId0', metadata[:contactId]
      assert_equal 0, metadata[:contactIndex]
      assert_equal 'individual', metadata[:contactType]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_organization_party_complete

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@aIn[1]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'organizationId0', metadata[:contactId]
      assert_equal 2, metadata[:contactIndex]
      assert_equal 'organization', metadata[:contactType]
      assert_equal 2, metadata[:organizationMembers].length
      assert_equal 'individualId0', metadata[:organizationMembers][0][:contactId]
      assert_equal 0, metadata[:organizationMembers][0][:contactIndex]
      assert_equal 'individual', metadata[:organizationMembers][0][:contactType]
      assert_equal 0, metadata[:organizationMembers][0][:organizationMembers].length
      assert_equal 'individualId1', metadata[:organizationMembers][1][:contactId]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_party_id

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@aIn[1]))
      hIn['contactId'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson responsibility party contact ID is missing'

   end

   def test_missing_party_id

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@aIn[1]))
      hIn.delete('contactId')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'ERROR: mdJson responsibility party contact ID is missing'

   end

   def test_bad_party_id

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@aIn[2]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_bad_organizationMember_id

      TestReaderMdJsonParent.setContacts
      hIn = Marshal::load(Marshal.dump(@@aIn[3]))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 1, metadata[:organizationMembers].length
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_party

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],'WARNING: mdJson responsibility party object is empty'

   end

end
