# Reader - fgdc to internal data structure
# unpack fgdc metadata identification

# History:
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_citation'
require_relative 'module_timePeriod'
require_relative 'module_timeInstant'
require_relative 'module_spatialDomain'
require_relative 'module_keyword'
require_relative 'module_contact'
require_relative 'module_security'
require_relative 'module_taxonomy'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Identification

               def self.unpack(xIdInfo, intObj, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new

                  # useful parts
                  hMetadata = intObj[:metadata]
                  hResourceInfo = hMetadata[:resourceInfo]

                  # identification information 1.1 (citation) - citation (required)
                  xCitation = xIdInfo.xpath('./citation')
                  unless xCitation.empty?
                     hCitation = Citation.unpack(xCitation, hResponseObj)
                     hResourceInfo[:citation] = hCitation unless hCitation.nil?
                  end

                  # identification information 1.2 (descript) - description (required)
                  xDescription = xIdInfo.xpath('./descript')
                  unless xDescription.empty?

                     # description 1.2.1 (abstract) - abstract
                     abstract = xDescription.xpath('./abstract').text
                     hResourceInfo[:abstract] = abstract unless abstract.empty?

                     # description 1.2.2 (purpose) - purpose
                     purpose = xDescription.xpath('./purpose').text
                     hResourceInfo[:purpose] = purpose unless purpose.empty?

                     # description 1.2.3 (supplinf) - supplemental information
                     supplemental = xDescription.xpath('./supplinf').text
                     hResourceInfo[:supplementalInfo] = supplemental unless supplemental.empty?

                  end

                  # identification information 1.3 (timeperd) - time period of content
                  xTimePeriod = xIdInfo.xpath('./timeperd')
                  unless xTimePeriod.empty?

                     # timeInfo currentness
                     current = xTimePeriod.xpath('./current').text

                     # time period for single date, multi-date, and date range {resource timePeriod}
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     hResourceInfo[:timePeriod] = hTimePeriod unless hTimePeriod.nil?
                     hResourceInfo[:timePeriod][:description] = current

                     # time period multi-date also placed in temporalExtent
                     axMultiple = xTimePeriod.xpath('./timeinfo/mdattim/sngdate')
                     unless axMultiple.empty?
                        hExtent = intMetadataClass.newExtent
                        hExtent[:description] = 'FGDC resource time period for multiple date/times/geological age'
                        axMultiple.each do |xDateTime|
                           hInstant = TimeInstant.unpack(xDateTime, hResponseObj)
                           unless hInstant.nil?
                              hTempExtent = intMetadataClass.newTemporalExtent
                              hInstant[:description] = current
                              hTempExtent[:timeInstant] = hInstant
                              hExtent[:temporalExtents] << hTempExtent
                           end
                        end
                        hResourceInfo[:extents] << hExtent unless hExtent[:temporalExtents].empty?
                     end

                  end

                  # identification information 1.4 (status) - status and maintenance
                  xStatus = xIdInfo.xpath('./status')
                  unless xStatus.empty?

                     # status 1.4.1 (progress) - state of resource
                     progress = xStatus.xpath('./progress').text
                     hResourceInfo[:status] << progress unless progress.empty?

                     # status 1.4.2 (update) - maintenance frequency
                     update = xStatus.xpath('./update').text
                     unless update.empty?
                        hMaintenance = intMetadataClass.newMaintenance
                        hMaintenance[:frequency] = update
                        hResourceInfo[:resourceMaintenance] << hMaintenance
                     end

                  end

                  # identification information 1.5 (spdom) - spatial domain
                  xDomain = xIdInfo.xpath('./spdom')
                  unless xDomain.empty?
                     hExtent = SpatialDomain.unpack(xDomain, hResponseObj)
                     hResourceInfo[:extents] << hExtent unless hExtent.nil?
                  end

                  # identification information 1.6 (keywords) - keywords
                  xKeywords = xIdInfo.xpath('./keywords')
                  unless xKeywords.empty?
                     Keyword.unpack(xKeywords, hResourceInfo, hResponseObj)
                  end

                  # identification information bio (taxonomy) - taxonomic information
                  xTaxonomy = xIdInfo.xpath('./taxonomy')
                  unless xTaxonomy.empty?
                     hTaxonomy = Taxonomy.unpack(xTaxonomy, hResourceInfo, hResponseObj)
                     unless hTaxonomy.nil?
                        hResourceInfo[:taxonomy] = hTaxonomy
                     end
                  end

                  # identification information 1.7 (accconst) - access constraints
                  # identification information 1.8 (useconst) - use constraints
                  accessCon = xIdInfo.xpath('./accconst').text
                  useCon = xIdInfo.xpath('./useconst').text
                  hConstraint = intMetadataClass.newConstraint
                  hConstraint[:type] = 'legal'
                  hLegal = intMetadataClass.newLegalConstraint

                  hLegal[:accessCodes] << accessCon unless accessCon.empty?
                  hLegal[:useCodes] << useCon unless useCon.empty?
                  hLegal[:otherCons] << accessCon unless accessCon.empty?
                  hLegal[:otherCons] << useCon unless useCon.empty?
                  unless hLegal[:otherCons].empty?
                     hConstraint[:legalConstraint] = hLegal
                     hResourceInfo[:constraints] << hConstraint
                  end

                  # identification information 1.9 (ptcontac) - point of contact {contact}
                  xContact = xIdInfo.xpath('./ptcontac')
                  unless xContact.empty?
                     hResponsibility = Contact.unpack(xContact, hResponseObj)
                     unless hResponsibility.nil?
                        hResponsibility[:roleName] = 'pointOfContact'
                        hResourceInfo[:pointOfContacts] << hResponsibility
                     end
                  end

                  # identification information 1.10 (browse) - browse graphic []
                  axBrowse = xIdInfo.xpath('//browse')
                  unless axBrowse.empty?
                     axBrowse.each do |xBrowse|
                        browseName = xBrowse.xpath('./browsen').text
                        browseDesc = xBrowse.xpath('./browsed').text
                        browseType = xBrowse.xpath('./browset').text
                        hGraphic = intMetadataClass.newGraphic
                        hGraphic[:graphicName] = browseName unless browseName.empty?
                        hGraphic[:graphicDescription] = browseDesc unless browseDesc.empty?
                        hGraphic[:graphicType] = browseType unless browseType.empty?
                        hResourceInfo[:graphicOverviews] << hGraphic
                     end
                  end

                  # identification information 1.11 (datacred) - data credit
                  credits = xIdInfo.xpath('./datacred').text
                  unless credits.empty?
                     hResourceInfo[:credits] << credits
                  end

                  # identification information 1.12 (secinfo) - security information
                  xSecurity = xIdInfo.xpath('./secinfo')
                  unless xSecurity.empty?
                     hConstraint = Security.unpack(xSecurity, hResponseObj)
                     hResourceInfo[:constraints] << hConstraint unless hConstraint.nil?
                  end

                  # identification information 1.13 (native) - native dataset environment
                  native = xIdInfo.xpath('./native').text
                  unless native.empty?
                     hResourceInfo[:environmentDescription] = native
                  end

                  # identification information 1.14 (crossref) - cross reference {associatedResource}
                  xCitation = xIdInfo.xpath('./crossref')
                  unless xCitation.empty?
                     hCitation = Citation.unpack(xCitation, hResponseObj)
                     unless hCitation.empty?
                        hAssociatedResource = intMetadataClass.newAssociatedResource
                        hAssociatedResource[:associationType] = 'crossReference'
                        hAssociatedResource[:resourceCitation] = hCitation
                        hMetadata[:associatedResources] << hAssociatedResource
                     end
                  end

                  return intObj

               end

            end

         end
      end
   end
end
