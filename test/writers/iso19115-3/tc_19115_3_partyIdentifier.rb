require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter19115PartyIdentifier < TestWriter191151Parent
  TDClass = MdJsonHashWriter.new

   mdHash = TDClass.base


  hContact = TDClass.build_organization_full
  mdHash[:contact] << hContact

  @@mdHash = mdHash

  def test_organization_party_identifier
    hIn = Marshal::load(Marshal.dump(@@mdHash))

    parties = [
      {
        name: "organization name",
        isOrganization: true,
        contactId: "CID001",
        externalIdentifier: [
          {
            identifier: "ror:02z5nhe81",
            namespace: "ror"
          }
        ] 
      },
      {
        name: "person name",
        isOrganization: false,
        contactId: "CID002",
        externalIdentifier: [
          {
            identifier: "https://orcid.org/0000-0002-4472-5965",
            namespace: "orcid"
          }
        ]  
      },
    ]

    hIn[:contact] = parties

    hIn[:metadata][:metadataInfo][:metadataContact][0][:party] = [parties[1]]
    hIn[:metadata][:resourceInfo][:pointOfContact][0][:party] = [parties[0]]

    hIn[:metadata][:resourceInfo][:citation][:responsibleParty][0][:party] = parties

    hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_partyIdentifier', '//cit:party[1]', '//cit:party', 0)

    assert_equal hReturn[0], hReturn[1]
    assert hReturn[2]
    assert_empty hReturn[3]
  end

end
