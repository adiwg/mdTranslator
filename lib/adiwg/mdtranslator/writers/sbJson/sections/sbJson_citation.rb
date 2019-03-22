# sbJson 1.0 writer citation

# History:
#  Stan Smith 2017-05-16 original script

require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Citation

               # build from citation as follows ...
               # names, [] {citation.responsibleParty[]}
               # dates(type), [] {citation.dates[]}
               # title, {citation.title}
               # uri, [] {citation.onlineResource[]}
               def self.build(hCitation)

                  citation = ''

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
                           citation += hContact[:name] + '(' + sbRole + '), '
                        end
                     end
                  end

                  # dates
                  hCitation[:dates].each do |hDate|
                     dateStr = AdiwgDateTimeFun.stringDateFromDateObject(hDate)
                     dateType = Codelists.codelist_adiwg2sb('date_adiwg2sb', hDate[:dateType])
                     unless dateType.nil?
                        citation += dateStr + '(' + dateType + '), '
                     end
                  end

                  # title
                  citation += hCitation[:title] + ', '

                  # uri
                  hCitation[:onlineResources].each do |hOnline|
                     citation += hOnline[:olResURI] + ', '
                  end

                  # clean off last comma
                  if citation.length > 0
                     citation = citation[0...-2]
                  end

                  citation

               end

            end

         end
      end
   end
end
