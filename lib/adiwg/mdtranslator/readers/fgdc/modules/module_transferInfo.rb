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

               def self.unpack(xTranInfo, hTransfer, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hFormat = intMetadataClass.newResourceFormat
                  hSpecification = intMetadataClass.newCitation
                  hFormat[:formatSpecification] = hSpecification
                  hTransfer[:distributionFormats] << hFormat

                  # distribution 6.4.2.1.1 (formname) - format name
                  # -> distribution.distributor.transferOption.distributionFormat.formatSpecification.title
                  title = xTranInfo.xpath('./formname').text
                  unless title.empty?
                     hSpecification[:title] = title
                  end

                  # distribution 6.4.2.1.2 (formvern) - format version number
                  # -> distribution.distributor.transferOption.distributionFormat.formatSpecification.edition
                  version = xTranInfo.xpath('./formvern').text
                  unless version.empty?
                     hSpecification[:edition] = version
                  end

                  # distribution 6.4.2.1.3 (formverd) - format version date
                  # -> distribution.distributor.transferOption.distributionFormat.formatSpecification.date(version)
                  date = xTranInfo.xpath('./formverd').text
                  unless date.empty?
                     hDate = Date.unpack(date, '', 'revision', hResponseObj)
                     unless hDate.nil?
                        hSpecification[:dates] << hDate
                     end
                  end

                  # distribution 6.4.2.1.4 (formspec) - format specification
                  # -> distribution.distributor.transferOption.distributionFormat.formatSpecification.otherCitationDetails
                  specification = xTranInfo.xpath('./formspec').text
                  unless specification.empty?
                     hSpecification[:otherDetails] << specification
                  end

                  # distribution 6.4.2.1.5 (formcont) - format information content
                  # -> distribution.distributor.transferOption.distributionFormat.formatSpecification.otherCitationDetails
                  specification = xTranInfo.xpath('./formcont').text
                  unless specification.empty?
                     hSpecification[:otherDetails] << specification
                  end

                  # distribution 6.4.2.1.6 (filedec) - file decompression technique
                  # -> distribution.distributor.transferOption.distributionFormat.compressionMethod
                  compress = xTranInfo.xpath('./filedec').text
                  unless compress.empty?
                     hFormat[:compressionMethod] = compress
                  end

                  # distribution 6.4.2.1.7 (transize) - file transfer size in MB
                  # -> distribution.distributor.transferOption.transferSize
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
