# MdTranslator - minitest of
# writers / fgdc / class_contact

# History:
#  Stan Smith 2017-11-27 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcContact < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hContact1 = mdHash[:contact][0]
   TDClass.add_address(hContact1, ['physical'])
   TDClass.add_phone(hContact1, '222-222-2222', %w(facsimile tty other))
   TDClass.add_phone(hContact1, '333-333-3333', %w(tty voice fax))
   hContact1[:memberOfOrganization] = []
   hContact1[:memberOfOrganization] << 'CID002'
   hContact1[:electronicMailAddress] = []
   hContact1[:electronicMailAddress] = %w(name1@adiwg.org name2@adiwg.org)
   hContact1[:onlineResource] = []
   hContact1[:onlineResource] << TDClass.build_onlineResource('https://adiwg.org/1')
   hContact1[:onlineResource] << TDClass.build_onlineResource('https://adiwg.org/2')
   hContact1[:hoursOfService] = ['8-5 weekdays','10-2 Saturday']
   hContact1[:contactInstructions] = 'contact instructions'
   hContact1[:contactType] = 'contact type'

   hContact2 = TDClass.build_organization('CID002', 'organization name')
   mdHash[:contact] << hContact2

   @@mdHash = mdHash

   def test_contact_person_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'contact_person', './metadata/idinfo/ptcontac')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_contact_organization_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:isOrganization] = true
      hIn[:contact][0][:name] = 'organization name'

      hReturn = TestWriterFGDCParent.get_complete(hIn, 'contact_organization', './metadata/idinfo/ptcontac')
      assert_equal hReturn[0], hReturn[1]

   end

   def test_contact_person_name

      # name empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:name] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Person Contact is missing name'

      # name missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0].delete(:name)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Person Contact is missing name'

   end

   def test_contact_address

      # address empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Contact is missing address'

      # address missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0].delete(:address)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Contact is missing address'

   end

   def test_contact_voice_phone

      # no voice phone
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:phone][0][:service] = ['other']
      hIn[:contact][0][:phone][1][:service] = ['other']
      hIn[:contact][0][:phone][2][:service] = ['other']
      hIn = hIn.to_json

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Contact is missing voice phone'

   end

   def test_contact_address_elements

      # address city empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:city] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Address is missing city'

      # address city missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0].delete(:city)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Address is missing city'

      # address state empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:administrativeArea] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Address is missing state'

      # address state missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0].delete(:administrativeArea)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Address is missing state'

      # address postal code empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0][:postalCode] = ''

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Address is missing postal code'

      # address postal code missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:contact][0][:address][0].delete(:postalCode)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_includes hResponseObj[:writerMessages], 'Address is missing postal code'

   end

end
