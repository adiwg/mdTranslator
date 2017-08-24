# MdTranslator - minitest of
# readers / fgdc / module_publication

# History:
#   Stan Smith 2017-08-23 original script

require_relative 'fgdc_test_parent'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_publication'

class TestReaderFgdcPublication < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('publication.xml')
   @@xPublication = @@xDoc.xpath('./metadata/citation/citeinfo/pubinfo')

   @@FgdcNameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Fgdc
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Publication

   def test_publication_complete

      TestReaderFGDCParent.set_intObj

      hResponsibility = @@NameSpace.unpack(@@xPublication, @@hResponseObj)

      refute_empty hResponsibility
      assert_equal 'publisher', hResponsibility[:roleName]
      assert_empty hResponsibility[:roleExtents]
      assert_equal 1, hResponsibility[:parties].length

      hParty = hResponsibility[:parties][0]
      refute_nil hParty[:contactId]
      assert_equal 0, hParty[:contactIndex]
      assert_equal 'organization', hParty[:contactType]
      assert_empty hParty[:organizationMembers]

      hContact = @@FgdcNameSpace.get_contact_by_id(hParty[:contactId])
      assert hContact[:isOrganization]
      assert_equal 'My Publisher', hContact[:name]
      assert_equal 1, hContact[:addresses].length

      hAddress = hContact[:addresses][0]
      assert_equal 1, hAddress[:addressTypes].length
      assert_equal 'mailing', hAddress[:addressTypes][0]
      assert_equal 'City, State, USA', hAddress[:description]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
