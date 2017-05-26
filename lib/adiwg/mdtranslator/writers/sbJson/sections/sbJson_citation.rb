# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-16 original script

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
                  role = ''

                  # names
                  aIndexes = []
                  hCitation[:responsibleParties].each do |hResponsibility|
                     role = hResponsibility[:roleName]
                     hResponsibility[:parties].each do |hParty|
                        party = {}
                        party[:role] = role
                        party[:index] = hParty[:contactIndex]
                        aIndexes << party
                        hParty[:organizationMembers].each do |hMember|
                           party = {}
                           party[:role] = role
                           party[:index] = hMember[:contactIndex]
                           aIndexes << party
                        end
                     end
                  end
                  aIndexes.uniq!
                  aIndexes.each do |hIndex|
                     hContact = ADIWG::Mdtranslator::Writers::SbJson.get_contact_by_index(hIndex[:index])
                     unless hContact.empty?
                        unless hContact[:name].nil?
                           citation += hContact[:name] + '(' + hIndex[:role] + '), '
                        end
                     end
                  end

                  # dates
                  hCitation[:dates].each do |hDate|
                     dateStr = AdiwgDateTimeFun.stringFromDateObject(hDate)
                     citation += dateStr + '(' + hDate[:dateType] + '), '
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
