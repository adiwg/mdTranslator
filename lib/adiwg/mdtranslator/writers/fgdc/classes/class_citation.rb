# FGDC <<Class>> Citation
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-02-26 refactored error and warning messaging
#  Stan Smith 2017-11-17 original script

require 'adiwg/mdtranslator/internal/module_dateTimeFun'
require_relative '../fgdc_writer'
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
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hCitation, aAssocResource, inContext = nil)
                  
                  # classes used
                  seriesClass = Series.new(@xml, @hResponseObj)
                  pubClass = Publisher.new(@xml, @hResponseObj)
                  citationClass = Citation.new(@xml, @hResponseObj)

                  @xml.tag!('citeinfo') do

                     # citation 8.1 (origin) - originator [] (required)
                     # <- hCitation[:responsibleParties] role = 'originator'
                     haveOriginator = false
                     aRParties = hCitation[:responsibleParties]
                     aOriginators = @NameSpace.find_responsibility(aRParties, 'originator')
                     aOriginators.each do |contactId|
                        hContact = @NameSpace.get_contact(contactId)
                        unless hContact.empty?
                           name = hContact[:name]
                           unless name.nil?
                              @xml.tag!('origin', name)
                              haveOriginator = true
                           end
                        end
                     end
                     unless haveOriginator
                        @NameSpace.issueWarning(30,'origin', inContext)
                     end

                     # citation 8.2 (pubdate) - publication date (required)
                     # citation 8.3 (pubtime) - publication time
                     # <- hCitation[:dates] dateType = 'publication'
                     havePubDate = false
                     havePubTime = false
                     hCitation[:dates].each do |hDate|
                        unless hDate.empty?
                           unless hDate[:dateType].nil?
                              if hDate[:dateType] == 'publication'
                                 pubDate = AdiwgDateTimeFun.stringDateFromDateTime(hDate[:date], hDate[:dateResolution])
                                 pubTime = AdiwgDateTimeFun.stringTimeFromDateTime(hDate[:date], hDate[:dateResolution])
                                 pubDate.gsub!(/[-]/,'')
                                 unless pubDate == 'ERROR'
                                    @xml.tag!('pubdate', pubDate)
                                    havePubDate = true
                                 end
                                 unless pubTime == 'ERROR'
                                    @xml.tag!('pubtime', pubTime)
                                    havePubTime = true
                                 end
                                 break
                              end
                           end
                        end
                     end
                     unless havePubDate
                        @NameSpace.issueWarning(31,'pubdate', inContext)
                     end
                     if !havePubTime && @hResponseObj[:writerShowTags]
                        @xml.tag!('pubtime')
                     end

                     # citation 8.4 (title) - title (required)
                     # <- hCitation[:title]
                     unless hCitation[:title].nil? || hCitation[:title] == ''
                        @xml.tag!('title', hCitation[:title])
                     end
                     if hCitation[:title].nil? || hCitation[:title] == ''
                        @NameSpace.issueWarning(32,'title', inContext)
                     end

                     # citation 8.5 (edition) - edition
                     # <- hCitation[:edition]
                     unless hCitation[:edition].nil?
                        @xml.tag!('edition', hCitation[:edition])
                     end
                     if hCitation[:edition].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('edition')
                     end

                     # citation 8.6 (geoform) - geospatial data presentation form
                     # <- hCitation[:presentationForm] [] - take first
                     hCitation[:presentationForms].each do |geoForm|
                        unless geoForm.empty?
                           @xml.tag!('geoform', geoForm)
                           break
                        end
                     end
                     if hCitation[:presentationForms].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('geoform')
                     end

                     # citation 8.7 (serinfo) - series information
                     # <- hCitation[:series]
                     unless hCitation[:series].empty?
                        @xml.tag!('serinfo') do
                           seriesClass.writeXML(hCitation[:series])
                        end
                     end
                     if hCitation[:series].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('serinfo')
                     end

                     # citation 8.8 (pubinfo) - publication information
                     # <- hCitation[:responsibleParties] role = 'publisher'
                     # only take first publisher
                     havePublisher = false
                     aRParties = hCitation[:responsibleParties]
                     aPublisher = ADIWG::Mdtranslator::Writers::Fgdc.find_responsibility(aRParties, 'publisher')
                     unless aPublisher.empty?
                        hContact = ADIWG::Mdtranslator::Writers::Fgdc.get_contact(aPublisher[0])
                        unless hContact.empty?
                           @xml.tag!('pubinfo') do
                              pubClass.writeXML(hContact)
                              havePublisher = true
                           end
                        end
                     end
                     if !havePublisher && @hResponseObj[:writerShowTags]
                        @xml.tag!('pubinfo')
                     end

                     # citation 8.9 (othercit) - other citation details
                     # <- hCitation[:otherDetails][0] - take first
                     unless hCitation[:otherDetails].empty?
                        @xml.tag!('othercit', hCitation[:otherDetails][0])
                     end
                     if hCitation[:otherDetails].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('othercit')
                     end

                     # citation 8.10 (onlink) - online linkage []
                     # <- hCitation[:onlineResources][:uri]
                     hCitation[:onlineResources].each do |hOnline|
                        unless hOnline[:olResURI].nil?
                           @xml.tag!('onlink', hOnline[:olResURI])
                        end
                     end
                     if hCitation[:onlineResources].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('onlink')
                     end

                     # citation 8.11 (lworkcit) - larger work citation
                     # <- associatedResource[] - associationType = 'largerWorkCitation' take first
                     # <- associatedResource[:resourceCitation]
                     haveLarger = false
                     aAssocResource.each do |hResource|
                        if hResource[:associationType] == 'largerWorkCitation'
                           unless hResource[:resourceCitation].empty?
                              @xml.tag!('lworkcit') do
                                 citationClass.writeXML(hResource[:resourceCitation], [])
                                 haveLarger = true
                              end
                              break
                           end
                        end
                     end
                     if !haveLarger && @hResponseObj[:writerShowTags]
                        @xml.tag!('lworkcit')
                     end

                  end # citeinfo tag
               end # writeXML
            end # Citation

         end
      end
   end
end
