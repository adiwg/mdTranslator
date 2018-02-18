# Reader - fgdc to internal data structure
# unpack fgdc security

# History:
#  Stan Smith 2017-08-25 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Security

               def self.unpack(xSecurity, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hConstraint = intMetadataClass.newConstraint
                  hConstraint[:type] = 'security'
                  hSecurity = intMetadataClass.newSecurityConstraint

                  # series 1.12.1 (secsys) - security system name (required)
                  system = xSecurity.xpath('./secsys').text
                  hSecurity[:classSystem] = system unless system.empty?
                  if system.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC security system name is missing'
                  end

                  # series 1.12.2 (secclass) - security classification (required)
                  secClass = xSecurity.xpath('./secclass').text
                  hSecurity[:classCode] = secClass unless secClass.empty?
                  if secClass.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC security classification is missing'
                  end

                  # series 1.12.3 (sechandl) - security handling instructions (required)
                  secHand = xSecurity.xpath('./sechandl').text
                  hSecurity[:handling] = secHand unless secHand.empty?
                  if secHand.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC security handling instructions are missing'
                  end

                  hConstraint[:securityConstraint] = hSecurity

                  return hConstraint

               end

            end

         end
      end
   end
end
