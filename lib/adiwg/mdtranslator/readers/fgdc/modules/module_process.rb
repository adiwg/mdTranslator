# Reader - fgdc to internal data structure
# unpack fgdc process

# History:
#  Stan Smith 2017-08-28 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_dateTime'
require_relative 'module_contact'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Process

               def self.unpack(xProcess, hLineage, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hProcess = intMetadataClass.newProcessStep

                  # process 2.5.2.1 (procdesc) - process description
                  description = xProcess.xpath('./procdesc').text
                  unless description.empty?
                     hProcess[:description] = description
                  end

                  # process 2.5.2.2 (srcused) - source used citation abbreviation []
                  axUsed = xProcess.xpath('./srcused')
                  unless axUsed.empty?
                     axUsed.each do |xUsed|
                        usedSrc = xUsed.text
                        unless usedSrc.empty?
                           hLineage[:dataSources].each do |hSource|
                              unless hSource[:sourceId].nil?
                                 if usedSrc == hSource[:sourceId]
                                    hProcess[:stepSources] << hSource
                                 end
                              end
                           end
                        end
                     end
                  end

                  # process 2.5.2.3/2.5.2.4 (procdate/proctime) - procedure date/time {date} (required) {time} (optional)
                  procDate = xProcess.xpath('./procdate').text
                  procTime = xProcess.xpath('./proctime').text
                  unless procDate.empty?
                     hDateTime = DateTime.unpack(procDate, procTime, hResponseObj)
                     unless hDateTime.nil?
                        hTimePeriod = intMetadataClass.newTimePeriod
                        hTimePeriod[:description] = 'Step completion dateTime'
                        hTimePeriod[:endDateTime] = hDateTime
                        hProcess[:timePeriod] = hTimePeriod
                     end
                  end

                  # process 2.5.2.5 (srcprod) - source produced citation abbreviation []
                  axProduct = xProcess.xpath('./srcprod')
                  unless axProduct.empty?
                     axProduct.each do |xProduct|
                        prodSrc = xProduct.text
                        unless prodSrc.empty?
                           hLineage[:dataSources].each do |hSource|
                              unless hSource[:sourceId].nil?
                                 if prodSrc == hSource[:sourceId]
                                    hProcess[:stepProducts] << hSource
                                 end
                              end
                           end
                        end
                     end
                  end

                  # process 2.5.2.6 (proccont) - process contact {contact}
                  xContact = xProcess.xpath('./proccont')
                  unless xContact.empty?
                     hResponsibility = Contact.unpack(xContact, hResponseObj)
                     unless hResponsibility.nil?
                        hResponsibility[:roleName] = 'processor'
                        hProcess[:processors] << hResponsibility
                     end
                  end

                  return hProcess

               end

            end

         end
      end
   end
end
