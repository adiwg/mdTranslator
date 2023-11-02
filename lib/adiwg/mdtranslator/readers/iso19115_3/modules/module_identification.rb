# Reader - Iso19115_3 to internal data structure
# unpack Iso19115_3 metadata identification

# History:
#  Stan Smith 2018-09-06 bug fix - change crossReference processing to an array
#  Stan Smith 2018-04-06 change mdJson taxonomy to an array
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
         module Iso19115_3

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
                  if xCitation.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification section citation is missing'
                  end

                  # identification information 1.2 (descript) - description (required)
                  xDescription = xIdInfo.xpath('./descript')
                  unless xDescription.empty?

                     # description 1.2.1 (abstract) - abstract (required)
                     abstract = xDescription.xpath('./abstract').text
                     hResourceInfo[:abstract] = abstract unless abstract.empty?
                     if abstract.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification section abstract is missing'
                     end

                     # description 1.2.2 (purpose) - purpose (required)
                     purpose = xDescription.xpath('./purpose').text
                     hResourceInfo[:purpose] = purpose unless purpose.empty?
                     if purpose.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification section purpose is missing'
                     end

                     # description 1.2.3 (supplinf) - supplemental information
                     supplemental = xDescription.xpath('./supplinf').text
                     hResourceInfo[:supplementalInfo] = supplemental unless supplemental.empty?

                  end
                  if xDescription.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification section description is missing'
                  end


                  # identification information 1.3 (timeperd) - time period of content (required)
                  haveTimePeriod = false
                  xTimePeriod = xIdInfo.xpath('./timeperd')
                  unless xTimePeriod.empty?

                     # timeInfo currentness (required)
                     current = xTimePeriod.xpath('./current').text
                     if current.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification section time period currentness is missing'
                     end

                     # time period for single date, multi-date, and date range {resource timePeriod}
                     hTimePeriod = TimePeriod.unpack(xTimePeriod, hResponseObj)
                     hResourceInfo[:timePeriod] = hTimePeriod unless hTimePeriod.nil?
                     hResourceInfo[:timePeriod][:description] = current
                     haveTimePeriod = true unless hTimePeriod.nil?

                     # time period multi-date also placed in temporalExtent
                     axMultiple = xTimePeriod.xpath('./timeinfo/mdattim/sngdate')
                     unless axMultiple.empty?
                        hExtent = intMetadataClass.newExtent
                        hExtent[:description] = 'Iso19115_3 resource time period for multiple date/times/geological age'
                        axMultiple.each do |xDateTime|
                           hInstant = TimeInstant.unpack(xDateTime, hResponseObj)
                           unless hInstant.nil?
                              hTempExtent = intMetadataClass.newTemporalExtent
                              hInstant[:description] = current
                              hTempExtent[:timeInstant] = hInstant
                              hExtent[:temporalExtents] << hTempExtent
                              haveTimePeriod = true end
                        end
                        hResourceInfo[:extents] << hExtent unless hExtent[:temporalExtents].empty?
                     end

                  end
                  unless haveTimePeriod
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification section time period is missing'
                  end

                  # identification information 1.4 (status) - status and maintenance (required)
                  xStatus = xIdInfo.xpath('./status')
                  unless xStatus.empty?

                     # status 1.4.1 (progress) - state of resource (required)
                     progress = xStatus.xpath('./progress').text
                     hResourceInfo[:status] << progress unless progress.empty?
                     if progress.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification progress is missing'
                     end

                     # status 1.4.2 (update) - maintenance frequency (required)
                     update = xStatus.xpath('./update').text
                     unless update.empty?
                        hMaintenance = intMetadataClass.newMaintenance
                        hMaintenance[:frequency] = update
                        hResourceInfo[:resourceMaintenance] << hMaintenance
                     end
                     if update.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification update frequency is missing'
                     end

                  end
                  if xStatus.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification status is missing'
                  end

                  # identification information 1.5 (spdom) - spatial domain (required)
                  xDomain = xIdInfo.xpath('./spdom')
                  unless xDomain.empty?
                     hExtent = SpatialDomain.unpack(xDomain, hResponseObj)
                     hResourceInfo[:extents] << hExtent unless hExtent.nil?
                  end
                  if xDomain.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification spatial domain section is missing'
                  end

                  # identification information 1.6 (keywords) - keywords (required)
                  xKeywords = xIdInfo.xpath('./keywords')
                  unless xKeywords.empty?
                     Keyword.unpack(xKeywords, hResourceInfo, hResponseObj)
                     xTheme = xKeywords.xpath('./theme')
                     if xTheme.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification keyword section is missing theme keywords'
                     end
                  end
                  if xKeywords.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification keyword section is missing'
                  end

                  # identification information bio (taxonomy) - taxonomic information
                  xTaxonomy = xIdInfo.xpath('./taxonomy')
                  unless xTaxonomy.empty?
                     hTaxonomy = Taxonomy.unpack(xTaxonomy, hResourceInfo, hResponseObj)
                     unless hTaxonomy.nil?
                        hResourceInfo[:taxonomy] << hTaxonomy
                     end
                  end

                  # identification information 1.7 (accconst) - access constraints (required)
                  # identification information 1.8 (useconst) - use constraints (required)
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
                  if accessCon.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification access constraint is missing'
                  end
                  if useCon.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: Iso19115_3 reader: identification use constraint is missing'
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

                  # identification information 1.14 (crossref) - cross reference [] {associatedResource}
                  axCitation = xIdInfo.xpath('./crossref')
                  unless axCitation.empty?
                     axCitation.each do |xCitation|
                        hCitation = Citation.unpack(xCitation, hResponseObj)
                        unless hCitation.empty?
                           hAssociatedResource = intMetadataClass.newAssociatedResource
                           hAssociatedResource[:associationType] = 'crossReference'
                           hAssociatedResource[:resourceCitation] = hCitation
                           hMetadata[:associatedResources] << hAssociatedResource
                        end
                     end
                  end

                  return intObj

               end

            end

         end
      end
   end
end
