# Reader - fgdc to internal data structure
# unpack fgdc citation

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'uuidtools'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_fgdc'
require_relative 'module_date'
require_relative 'module_series'
require_relative 'module_publication'
require_relative 'module_onlineResource'
require_relative 'module_citation'
require_relative 'module_responsibility'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Citation

               def self.unpack(xCitation, hResponseObj)

                  xCiteInfo = xCitation.xpath('./citeinfo')

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hCitation = intMetadataClass.newCitation

                  # citation 8.1 (origin) - originator [] (required)
                  aContacts = []
                  axOrigins = xCiteInfo.xpath('./origin')
                  axOrigins.each do |xOrigin|
                     name = xOrigin.text
                     unless name.empty?
                        contactId = Fgdc.find_contact_by_name(name)
                        if contactId.nil?
                           # add a new contact for this originator
                           contactId = Fgdc.add_contact(name, false)
                           aContacts << contactId
                        else
                           aContacts << contactId
                        end
                     end
                  end
                  unless aContacts.empty?
                     hResponsibility = Responsibility.unpack(aContacts, 'originator', hResponseObj)
                     unless hResponsibility.nil?
                        hCitation[:responsibleParties] << hResponsibility
                     end
                  end

                  # citation 8.2/8.3 (pubdate/pubtime) - publication date/time {date} (required) {time} (optional)
                  pubDate = xCiteInfo.xpath('./pubdate').text
                  pubTime = xCiteInfo.xpath('./pubtime').text
                  unless pubDate.empty?
                     hDate = Date.unpack(pubDate, pubTime, 'publication', hResponseObj)
                     unless hDate.nil?
                        hCitation[:dates] << hDate
                     end
                  end

                  # citation 8.4 (title) - citation title (required)
                  title = xCiteInfo.xpath('./title').text
                  unless title.empty?
                     hCitation[:title] = title
                  end

                  # citation 8.5 (edition) - edition
                  edition = xCiteInfo.xpath('./edition').text
                  unless edition.empty?
                     hCitation[:edition] = edition
                  end

                  # citation 8.6 (geoform) - edition
                  presentationForm = xCiteInfo.xpath('./geoform').text
                  unless presentationForm.empty?
                     hCitation[:presentationForms] << presentationForm
                  end

                  # citation 8.7 (serinfo) - series information
                  xSeries = xCiteInfo.xpath('./serinfo')
                  unless xSeries.empty?
                     hSeries = Series.unpack(xSeries, hResponseObj)
                     unless hSeries.nil?
                        hCitation[:series] = hSeries
                     end
                  end

                  # citation 8.8 (pubinfo) - publication information
                  xPublication = xCiteInfo.xpath('./pubinfo')
                  unless xPublication.empty?
                     hResponsibility = Publication.unpack(xPublication, hResponseObj)
                     unless hResponsibility.nil?
                        hCitation[:responsibleParties] << hResponsibility
                     end
                  end

                  # citation 8.9 (othercit) - other citation details
                  other = xCiteInfo.xpath('./othercit').text
                  unless other.empty?
                     hCitation[:otherDetails] << other
                  end

                  # citation 8.10 (onlink) - online linkage []
                  axOnLink = xCiteInfo.xpath('./onlink')
                  unless axOnLink.empty?
                     description = 'Link to the resource described in this citation'
                     axOnLink.each do |xLink|
                        onLink = xLink.text
                        unless onLink.empty?
                           hURI = OnlineResource.unpack(onLink, description, hResponseObj)
                           unless hURI.nil?
                              hCitation[:onlineResources] << hURI
                           end
                        end
                     end
                  end

                  # citation 8.11 (lworkcit) - larger work citation
                  xLWCitation = xCiteInfo.xpath('./lworkcit')
                  unless xLWCitation.empty?
                     hLWCitation = Citation.unpack(xLWCitation, hResponseObj)
                     unless hLWCitation.nil?
                        hAssResource = intMetadataClass.newAssociatedResource
                        hAssResource[:associationType] = 'largerWorkCitation'
                        hAssResource[:resourceCitation] = hLWCitation
                        Fgdc.add_associated_resource(hAssResource)
                     end
                  end

                  return hCitation

               end

            end

         end
      end
   end
end
