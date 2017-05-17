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

                  # names
                  indexes = []
                  hCitation[:responsibleParties].each do |hResponsibility|
                     hResponsibility[:parties].each do |hParty|
                        indexes << hParty[:contactIndex]
                        hParty[:organizationMembers].each do |hMember|
                           indexes << hMember[:contactIndex]
                        end
                     end
                  end
                  indexes.uniq!
                  indexes.each do |index|
                     hContact = ADIWG::Mdtranslator::Writers::SbJson.getContact(index)
                     unless hContact.empty?
                        unless hContact[:name].nil?
                           citation += hContact[:name] + ', '
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
