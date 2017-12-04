# FGDC <<Class>> Identification Information
# FGDC CSDGM writer output in XML

# History:
#   Stan Smith 2017-11-17 original script

require_relative '../fgdc_writer'
require_relative 'class_citation'
require_relative 'class_description'
require_relative 'class_timePeriod'
require_relative 'class_status'
require_relative 'class_spatialDomain'
require_relative 'class_keyword'
require_relative 'class_contact'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Identification

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def find_responsibility(aResponsibility, roleName)
                  aParties = []
                  aResponsibility.each do |hRParty|
                     if hRParty[:roleName] == roleName
                        hRParty[:parties].each do |hParty|
                           aParties << hParty[:contactId]
                        end
                     end
                  end
                  aParties = aParties.uniq
                  return aParties
               end

               def writeXML(intObj)

                  # classes used
                  citationClass = Citation.new(@xml, @hResponseObj)
                  descriptionClass = Description.new(@xml, @hResponseObj)
                  timePeriodClass = TimePeriod.new(@xml, @hResponseObj)
                  statusClass = Status.new(@xml, @hResponseObj)
                  spDomainClass = SpatialDomain.new(@xml, @hResponseObj)
                  keywordClass = Keyword.new(@xml, @hResponseObj)
                  contactClass = Contact.new(@xml, @hResponseObj)

                  hResourceInfo = intObj[:metadata][:resourceInfo]

                  @xml.tag!('idinfo') do

                     # identification information 1.1 (citation) - citation (required)
                     # <- hResourceInfo[:citation]
                     hCitation = hResourceInfo[:citation]
                     aAssocResource = intObj[:metadata][:associatedResources]
                     unless hCitation.empty?
                        @xml.tag!('citation') do
                           citationClass.writeXML(hCitation, aAssocResource)
                        end
                     end
                     if hCitation.empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section is missing citation'
                     end

                     # identification information 1.2 (descript) - description (required)
                     # <- hResourceInfo[:abstract,:purpose,:supplementalInfo] (required)
                     unless hResourceInfo[:abstract].nil? && hResourceInfo[:purpose].nil? && hResourceInfo[:supplementalInfo].nil?
                        @xml.tag!('descript') do
                           descriptionClass.writeXML(hResourceInfo)
                        end
                     end
                     if hResourceInfo[:abstract].nil?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section is missing abstract'
                     end
                     if hResourceInfo[:purpose].nil?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section is missing purpose'
                     end

                     # identification information 1.3 (timeperd) - time period of content (required)
                     # <- hResourceInfo[:timePeriod]
                     unless hResourceInfo[:timePeriod].empty?
                        @xml.tag!('timeperd') do
                           timePeriodClass.writeXML(hResourceInfo[:timePeriod])
                        end
                     end
                     if hResourceInfo[:timePeriod].empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section is missing time period'
                     end

                     # identification information 1.4 (status) - status
                     statusClass.writeXML(hResourceInfo)

                     # identification information 1.5 (spdom) - spatial domain
                     # not required under biological extension rules
                     unless hResourceInfo[:extents].empty?
                        spDomainClass.writeXML(hResourceInfo[:extents])
                     end

                     # identification information 1.6 (keywords) - keywords [] (required)
                     unless hResourceInfo[:keywords].empty?
                        @xml.tag!('keywords') do
                           keywordClass.writeXML(hResourceInfo[:keywords])
                        end
                     end
                     if hResourceInfo[:keywords].empty?
                        @hResponseObj[:writerPass] = false
                        @hResponseObj[:writerMessages] << 'Identification section is missing keywords'
                     end

                     # identification information bio (taxonomy) - taxonomy
                     # identification information 1.7 (accconst) - access constraint (required)
                     # identification information 1.8 (useconst) - use constraint (required)

                     # identification information 1.9 (ptcontac) - point of contact
                     unless hResourceInfo[:pointOfContacts].empty?
                        aParties = find_responsibility(hResourceInfo[:pointOfContacts], 'pointOfContact')
                        unless aParties.empty?
                           hContact = ADIWG::Mdtranslator::Writers::Fgdc.get_contact(aParties[0])
                           unless hContact.empty?
                              @xml.tag!('ptcontac') do
                                 contactClass.writeXML(hContact)
                              end
                           end
                        end
                     end
                     if hResourceInfo[:pointOfContacts].empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('ptcontac')
                     end

                     # identification information 1.10 (browse) - browse graphic []
                     # identification information 1.11 (datacred) - dataset credit
                     # identification information 1.12 (secinfo) - security information
                     # identification information 1.13 (native) - native dataset environment
                     # identification information 1.14 (crossref) - cross reference []
                     # identification information bio (tool) - analytical tool [] (not supported)

                  end # idinfo tag
               end # writeXML
            end # Identification

         end
      end
   end
end
