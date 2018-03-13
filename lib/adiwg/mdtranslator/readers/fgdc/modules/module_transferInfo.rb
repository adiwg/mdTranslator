# Reader - fgdc to internal data structure
# unpack fgdc distribution digital transfer information

# History:
#  Stan Smith 2017-09-09 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_date'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module TransferInfo

               def self.unpack(xTranInfo, hTransfer, techPre, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hFormat = intMetadataClass.newResourceFormat
                  hSpecification = intMetadataClass.newCitation
                  hIdentifier = intMetadataClass.newIdentifier
                  hSpecification[:identifiers] << hIdentifier
                  hFormat[:formatSpecification] = hSpecification
                  hTransfer[:distributionFormats] << hFormat

                  # add technical prerequisite to resourceFormat
                  unless techPre.empty?
                     hFormat[:technicalPrerequisite] = techPre
                  end

                  # distribution 6.4.2.1.1 (formname) - format name (required)
                  # -> transferOption.distributionFormat.formatSpecification.title
                  # -> transferOption.distributionFormat.formatSpecification.identifier[].identifier
                  formName = xTranInfo.xpath('./formname').text
                  unless formName.empty?
                     hSpecification[:title] = formName
                     hSpecification[:identifiers][0][:identifier] = formName
                  end
                  if formName.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: distribution transfer format name is missing'
                  end

                  # distribution 6.4.2.1.2 (formvern) - format version number
                  # -> transferOption.distributionFormat.formatSpecification.edition
                  version = xTranInfo.xpath('./formvern').text
                  unless version.empty?
                     hSpecification[:edition] = version
                  end

                  # distribution 6.4.2.1.3 (formverd) - format version date
                  # -> transferOption.distributionFormat.formatSpecification.date(version)
                  date = xTranInfo.xpath('./formverd').text
                  unless date.empty?
                     hDate = Date.unpack(date, '', 'revision', hResponseObj)
                     unless hDate.nil?
                        hSpecification[:dates] << hDate
                     end
                  end

                  # distribution 6.4.2.1.4 (formspec) - format specification
                  # -> transferOption.distributionFormat.formatSpecification.title
                  specification = xTranInfo.xpath('./formspec').text
                  unless specification.empty?
                     hSpecification[:title] = specification
                  end

                  # distribution bio (asciistr) - ASCII file specification
                  # -> not mapped; cannot reliably merge with entity-attribute definition

                  # distribution 6.4.2.1.5 (formcont) - format information content
                  # -> transferOption.distributionFormat.formatSpecification.otherCitationDetails
                  specification = xTranInfo.xpath('./formcont').text
                  unless specification.empty?
                     hSpecification[:otherDetails] << specification
                  end

                  # distribution 6.4.2.1.6 (filedec) - file decompression technique
                  # -> transferOption.distributionFormat.compressionMethod
                  compress = xTranInfo.xpath('./filedec').text
                  unless compress.empty?
                     hFormat[:compressionMethod] = compress
                  end

                  # distribution 6.4.2.1.7 (transize) - file transfer size in MB
                  # -> transferOption.transferSize
                  size = xTranInfo.xpath('./transize').text
                  unless size.empty?
                     hTransfer[:transferSize] = size.to_i
                  end

                  return hTransfer

               end
            end

         end
      end
   end
end
