# sbJson 1.0 writer citation

# History:
#  Stan Smith 2017-05-16 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Citation

               def self.build(hCitation)

                  citation = ''

                  if hCitation[:otherDetails].length > 0
                     citation = hCitation[:otherDetails][0]
                     return citation
                  end

                  # names
                  aParties = []
                  hCitation[:responsibleParties].each do |hResponsibility|
                     role = hResponsibility[:roleName]
                     hResponsibility[:parties].each do |hParty|
                        party = {}
                        party[:role] = role
                        party[:contactId] = hParty[:contactId]
                        aParties << party
                        hParty[:organizationMembers].each do |memberId|
                           party = {}
                           party[:role] = role
                           party[:contactId] = memberId
                           aParties << party
                        end
                     end
                  end
                  aParties.uniq!
                  aParties.each do |hParty|
                     hContact = ADIWG::Mdtranslator::Writers::SbJson.get_contact_by_id(hParty[:contactId])
                     unless hContact.empty?
                        unless hContact[:name].nil?
                           sbRole = Codelists.codelist_adiwg2sb('role_adiwg2sb', hParty[:role])
                           sbRole = sbRole.nil? ? hParty[:role] : sbRole
                           if sbRole.downcase == 'author'
                              citation += hContact[:name] + ', '
                           end
                        end
                     end
                  end

                  # title
                  citation += hCitation[:title]

                  citation

               end

            end

         end
      end
   end
end
