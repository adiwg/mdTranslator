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
                     hContact = ADIWG::Mdtranslator::Writers::SbJson.getContact(hIndex[:index])
                     unless hContact.empty?
                        unless hContact[:name].nil?
                           citation += hContact[:name] + '(' + hIndex[:role] + '), '
                        end
                     end
                  end

                  # dates
                  hCitation[:dates].each do |hDate|
                     date = hDate[:date]
                     dateRes = hDate[:dateResolution]
                     unless date.nil?
                        case dateRes
                           when 'Y', 'YM', 'YMD'
                              dateStr = AdiwgDateTimeFun.stringDateFromDateTime(date, dateRes)
                           else
                              dateStr = AdiwgDateTimeFun.stringDateTimeFromDateTime(date, dateRes)
                        end
                        citation += dateStr.to_s + '(' + hDate[:dateType] + '), '
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
