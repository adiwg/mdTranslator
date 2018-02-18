# Reader - fgdc to internal data structure
# unpack fgdc metadata information

# History:
#  Stan Smith 2018-01-27 move constraints to metadataConstraints
#  Stan Smith 2017-08-15 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_date'
require_relative 'module_contact'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module MetadataInformation

               def self.unpack(xMetaInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hMetadataInfo = intMetadataClass.newMetadataInfo
                  hLegal = intMetadataClass.newLegalConstraint

                  # metadata information 7.1 (metd) - metadata date (required)
                  # -> metadataInfo.metadataDates.date{type=creation}
                  date = xMetaInfo.xpath('./metd').text
                  unless date.empty?
                     hDate = Date.unpack(date, '', 'creation', hResponseObj)
                     unless hDate.nil?
                        hMetadataInfo[:metadataDates] << hDate
                     end
                  end
                  if date.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC metadata creation date is missing'
                  end

                  # metadata information 7.2 (metrd) - metadata review date
                  # -> metadataInfo.metadataDates.date{type=review}
                  date = xMetaInfo.xpath('./metrd').text
                  unless date.empty?
                     hDate = Date.unpack(date, '', 'review', hResponseObj)
                     unless hDate.nil?
                        hMetadataInfo[:metadataDates] << hDate
                     end
                  end

                  # metadata information 7.3 (metfrd) - metadata future review date
                  # -> metadataInfo.metadataDates.date{type=nextReview}
                  date = xMetaInfo.xpath('./metfrd').text
                  unless date.empty?
                     hDate = Date.unpack(date, '', 'nextReview', hResponseObj)
                     unless hDate.nil?
                        hMetadataInfo[:metadataDates] << hDate
                     end
                  end

                  # metadata information 7.4 (metc) - metadata contact (required)
                  # -> metadataInfo.metadataContacts.responsibility{roleType=pointOfContact}
                  xContact = xMetaInfo.xpath('./metc')
                  unless xContact.empty?
                     hResponsibility = Contact.unpack(xContact, hResponseObj)
                     unless hResponsibility.nil?
                        hResponsibility[:roleName] = 'pointOfContact'
                        hMetadataInfo[:metadataContacts] << hResponsibility
                     end
                  end
                  if xContact.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC metadata point of contact is missing'
                  end

                  # metadata information 7.5 (metstdn) - metadata standard name (required)
                  # -> set by writer

                  # metadata information 7.6 (metstdv) - metadata standard version (required)
                  # -> set by writer

                  # metadata information 7.7 (mettc) - metadata time convention
                  # -> read by date/time modules

                  # metadata information 7.8 (metac) - metadata access constraint
                  # -> resourceInfo.constraints.legalConstraint.accessCodes
                  accessCode = xMetaInfo.xpath('metac').text
                  unless accessCode.empty?
                     hLegal[:accessCodes] << accessCode
                  end

                  # metadata information 7.9 (metuc) - metadata use constraint
                  # -> resourceInfo.constraints.legalConstraint.useCodes
                  useCode = xMetaInfo.xpath('metuc').text
                  unless useCode.empty?
                     hLegal[:useCodes] << useCode
                  end

                  legal = accessCode + useCode
                  if legal != ''
                     hConstraint = intMetadataClass.newConstraint
                     hConstraint[:type] = 'legal'
                     hConstraint[:legalConstraint] = hLegal
                     hMetadataInfo[:metadataConstraints] << hConstraint
                  end

                  # metadata information 7.10 (metsi) - metadata security information
                  xSecurity = xMetaInfo.xpath('./metsi')
                  unless xSecurity.empty?

                     hSecurity = intMetadataClass.newSecurityConstraint

                     # metadata information 7.10.1 (metscs) - metadata security classification system
                     # -> resourceInfo.constraints.securityConstraint.classificationSystem
                     system = xSecurity.xpath('./metscs').text
                     unless system.empty?
                        hSecurity[:classSystem] = system
                     end

                     # metadata information 7.10.2 (metsc) - metadata security classification
                     # -> resourceInfo.constraints.securityConstraint.classification
                     classCode = xSecurity.xpath('./metsc').text
                     unless classCode.empty?
                        hSecurity[:classCode] = classCode
                     end

                     # metadata information 7.10.3 (metshd) - metadata security handling description
                     # -> resourceInfo.constraints.securityConstraint.handlingDescription
                     handling = xSecurity.xpath('./metshd').text
                     unless handling.empty?
                        hSecurity[:handling] = handling
                     end

                     security = system + classCode + handling
                     if security != ''
                        hConstraint = intMetadataClass.newConstraint
                        hConstraint[:type] = 'security'
                        hConstraint[:securityConstraint] = hSecurity
                        hMetadataInfo[:metadataConstraints] << hConstraint
                     end

                  end

                  # metadata information 7.11 (metextns) - metadata extension []

                  # metadata information 7.11.1 (onlink) - online linkage []
                  # -> set by writer, reader assumes NBII biological extension is present

                  # metadata information 7.11.2 (metprof) - profile name
                  # -> set by writer, reader assumes NBII biological extension is present

                  return hMetadataInfo

               end

            end

         end
      end
   end
end
