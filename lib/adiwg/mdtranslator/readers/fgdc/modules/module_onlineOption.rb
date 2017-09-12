# Reader - fgdc to internal data structure
# unpack fgdc distribution digital online transfer

# History:
#  Stan Smith 2017-09-09 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_date'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module OnlineOption

               def self.unpack(xOnline, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  aOnlines = []

                  # distribution 6.4.2.2.1.2 (accinstr) - access instructions
                  # -> distribution.distributor.onlineOption.protocol
                  protocol = xOnline.xpath('./accinstr').text

                  # distribution 6.4.2.2.1.3 (oncomp) - online computer and operating system
                  # -> distribution.distributor.onlineOption.description
                  description = xOnline.xpath('./oncomp').text

                  # distribution 6.4.2.2.1.1 (computer) - computer contact information []
                  axComputers = xOnline.xpath('./computer')
                  unless axComputers.empty?
                     axComputers.each do |xComputer|

                        # distribution 6.4.2.2.1.1.1 (networka) - network address
                        xNetwork = xComputer.xpath('./networka')
                        unless xNetwork.empty?

                           # distribution 6.4.2.2.1.1.1.1 (networkr) - network resource name []
                           # -> distribution.distributor.onlineOption.uri
                           axURI = xNetwork.xpath('./networkr')
                           unless axURI.empty?
                              axURI.each do |network|
                                 uri = network.text
                                 unless uri.empty?
                                    hOnlineRes = intMetadataClass.newOnlineResource
                                    hOnlineRes[:olResURI] = uri
                                    hOnlineRes[:olResProtocol] = protocol unless protocol.empty?
                                    hOnlineRes[:olResDesc] = description unless description.empty?
                                    aOnlines << hOnlineRes
                                 end
                              end
                           end

                        end

                        # dialup section is deprecated and will not be supported in ADIwg toolkit
                        # distribution 6.4.2.2.1.1.2 (dialinst) - dialup instructions
                        # distribution 6.4.2.2.1.1.2.1 (lowbps) - lowest bits per second
                        # distribution 6.4.2.2.1.1.2.2 (highbps) - highest bits per second
                        # distribution 6.4.2.2.1.1.2.3 (numdata) - number of data bits per character {7|8}
                        # distribution 6.4.2.2.1.1.2.4 (numstop) - number of stop bits per exchange {1|2}
                        # distribution 6.4.2.2.1.1.2.5 (parity) - parity {none | odd | even | mark | space}
                        # distribution 6.4.2.2.1.1.2.6 (compress) - compression support
                        # distribution 6.4.2.2.1.1.2.7 (dialtel) - dialup telephone
                        # distribution 6.4.2.2.1.1.2.8 (dialfile) - dialup file name []

                     end
                  end

                  return aOnlines

               end
            end

         end
      end
   end
end
