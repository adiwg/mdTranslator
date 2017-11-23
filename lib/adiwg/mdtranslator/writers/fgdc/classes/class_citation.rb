# FGDC <<Class>> Citation
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-17 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative 'class_series'
require_relative 'class_publisher'
require_relative 'class_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Citation

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def find_responsibility(hCitation, roleName)
                  aParties = []
                  hCitation[:responsibleParties].each do |hRParty|
                     if hRParty[:roleName] == roleName
                        hRParty[:parties].each do |hParty|
                           aParties << hParty[:contactId]
                        end
                     end
                  end
                  aParties = aParties.uniq
                  return aParties
               end

               def writeXML(hCitation, aAssocResource)

                  seriesClass = Series.new(@xml, @hResponseObj)
                  pubClass = Publisher.new(@xml, @hResponseObj)
                  citationClass = Citation.new(@xml, @hResponseObj)

                  @xml.tag!('citeinfo') do

                     # citation 8.1 (origin) - originator [] (required)
                     # <- hCitation[:responsibleParties] role = 'originator'
                     haveOriginator = false
                     aOriginators = find_responsibility(hCitation, 'originator')
                     aOriginators.each do |contactId|
                        hContact = ADIWG::Mdtranslator::Writers::Fgdc.getContact(contactId)
                        unless hContact.empty?
                           name = hContact[:name]
                           unless name.nil?
                              @xml.tag!('origin', name)
                              haveOriginator = true
                           end
                        end
                     end
                     unless haveOriginator
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Citation is missing originator'
                     end

                     # citation 8.2 (pubdate) - publication date (required)
                     # citation 8.3 (pubtime) - publication time
                     # <- hCitation[:dates] dateType = 'publication'
                     havePubDate = false
                     hCitation[:dates].each do |hDate|
                        unless hDate.empty?
                           unless hDate[:dateType].nil?
                              if hDate[:dateType] == 'publication'
                                 pubDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:date], hDate[:dateResolution])
                                 pubTime = AdiwgDateTimeFun.stringTimeFromDateTime(hDate[:date], hDate[:dateResolution])
                                 unless pubDate == 'ERROR'
                                    @xml.tag!('pubdate', pubDate)
                                    havePubDate = true
                                 end
                                 unless pubTime == 'ERROR'
                                    @xml.tag!('pubtime', pubTime)
                                 end
                                 break
                              end
                           end
                        end
                     end
                     unless havePubDate
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Citation is missing publication date'
                     end

                     # citation 8.4 (title) - title (required)
                     # <- hCitation[:title]
                     unless hCitation[:title].nil? || hCitation[:title] == ''
                        @xml.tag!('title', hCitation[:title])
                     end
                     if hCitation[:title].nil? || hCitation[:title] == ''
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Citation is missing title'
                     end

                     # citation 8.5 (edition) - edition
                     # <- hCitation[:edition]
                     unless hCitation[:edition].nil?
                        @xml.tag!('edition', hCitation[:edition])
                     end

                     # citation 8.6 (geoform) - geospatial data presentation form
                     # <- hCitation[:presentationForm] [] - take first
                     hCitation[:presentationForms].each do |geoForm|
                        unless geoForm.empty?
                           @xml.tag!('geoform', geoForm)
                           break
                        end
                     end

                     # citation 8.7 (serinfo) - series information
                     # <- hCitation[:series]
                     unless hCitation[:series].empty?
                        @xml.tag!('serinfo') do
                           seriesClass.writeXML(hCitation[:series])
                        end
                     end

                     # citation 8.8 (pubinfo) - publication information
                     # <- hCitation[:responsibleParties] role = 'publisher'
                     # only take first publisher
                     aPublisher = find_responsibility(hCitation, 'publisher')
                     unless aPublisher.empty?
                        hContact = ADIWG::Mdtranslator::Writers::Fgdc.getContact(aPublisher[0])
                        unless hContact.empty?
                           @xml.tag!('pubinfo') do
                              pubClass.writeXML(hContact)
                           end
                        end
                     end

                     # citation 8.9 (othercit) - other citation details
                     # <- hCitation[:otherDetails][0] - take first
                     unless hCitation[:otherDetails].empty?
                        @xml.tag!('othercit', hCitation[:otherDetails][0])
                     end

                     # citation 8.10 (onlink) - online linkage []
                     # <- hCitation[:onlineResources][:uri]
                     hCitation[:onlineResources].each do |hOnline|
                        unless hOnline[:olResURI].nil?
                           @xml.tag!('onlink', hOnline[:olResURI])
                        end
                     end

                     # citation 8.11 (lworkcit) - larger work citation
                     # <- associatedResource[] - associationType = 'largerWorkCitation' take first
                     # <- associatedResource[:resourceCitation]
                     aAssocResource.each do |hResource|
                        if hResource[:associationType] == 'largerWorkCitation'
                           unless hResource[:resourceCitation].empty?
                              @xml.tag!('lworkcit') do
                                 citationClass.writeXML(hResource[:resourceCitation], [])
                              end
                              break
                           end
                        end
                     end

                  end # citeinfo tag
               end # writeXML
            end # Citation

         end
      end
   end
end
