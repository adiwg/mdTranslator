# Reader - fgdc to internal data structure
# unpack fgdc distribution digital offline transfer

# History:
#  Stan Smith 2017-09-09 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_date'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module OfflineOption

               def self.unpack(xOffline, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hOffline = intMetadataClass.newMedium
                  aDensity = []
                  aOfflines = []

                  # distribution 6.4.2.2.2.1 (offmedia) - offline media (required)
                  # -> distribution.distributor.offlineOption.mediumSpecification.title
                  title = xOffline.xpath('./offmedia').text
                  unless title.empty?
                     hSpecification = intMetadataClass.newCitation
                     hSpecification[:title] = title
                     hOffline[:mediumSpecification] = hSpecification
                  end
                  if title.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: offline transfer media type is missing'
                  end

                  # distribution 6.4.2.2.2.2 (reccap) - recording capacity
                  xCapacity = xOffline.xpath('./reccap')
                  unless xCapacity.empty?

                     # distribution 6.4.2.2.2.2.1 (recden) - recording density [] (required)
                     # -> distribution.distributor.offlineOption.density
                     axDensity = xCapacity.xpath('./recden')
                     unless axDensity.empty?
                        axDensity.each do |xDensity|
                           density = xDensity.text
                           unless density.empty?
                              aDensity << density.to_i
                           end
                        end
                     end
                     if axDensity.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: offline transfer recording density is missing'
                     end

                     # distribution 6.4.2.2.2.2.2 (recdenu) - recording density units (required)
                     # -> distribution.distributor.offlineOption.units
                     units = xCapacity.xpath('./recdenu').text
                     unless units.empty?
                        hOffline[:units] = units
                     end
                     if units.empty?
                        hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: offline transfer recording density units are missing'
                     end

                  end

                  # distribution 6.4.2.2.2.3 (recfmt) - recording format [] (required)
                  # -> distribution.distributor.offlineOption.mediumFormat
                  axFormat = xOffline.xpath('./recfmt')
                  unless axFormat.empty?
                     axFormat.each do |xFormat|
                        format = xFormat.text
                        unless format.empty?
                           hOffline[:mediumFormat] << format
                        end
                     end
                  end
                  if axFormat.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC reader: offline transfer recording format is missing'
                  end

                  # distribution 6.4.2.2.2.4 (compat) - compatibility information
                  # -> distribution.distributor.offlineOption.note
                  note = xOffline.xpath('./compat').text
                  unless note.empty?
                     hOffline[:note] = note
                  end

                  # create an offline object for each density
                  if aDensity.empty?
                     aOfflines << hOffline
                  else
                     aDensity.each do |density|
                        hClone = hOffline.clone
                        hClone[:density] = density
                        aOfflines << hClone
                     end
                  end

                  return aOfflines

               end
            end

         end
      end
   end
end
