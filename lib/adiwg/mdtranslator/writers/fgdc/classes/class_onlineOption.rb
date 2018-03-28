# FGDC <<Class>> OnlineOption
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-16 refactored error and warning messaging
#  Stan Smith 2018-01-31 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class OnlineOption

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hOnline, inContext)
                  
                  # online option 6.4.2.2.1.1 (computer) - computer contact information (compound)
                  @xml.tag!('computer') do

                     # online option 6.4.2.2.1.1.1 (networka) - network address (compound)
                     @xml.tag!('networka') do

                        # online option 6.4.2.2.1.1.1.1 (networkr) - network resource name (required)
                        # <- onlineOption.olResURI
                        unless hOnline[:olResURI].nil?
                           @xml.tag!('networkr', hOnline[:olResURI])
                        end
                        if hOnline[:olResURI].nil?
                           @NameSpace.issueWarning(130,'networkr', 'distribution')
                        end

                     end

                     # online option 6.4.2.2.1.1.2 (dialinst) - dial-up instructions
                     # not supporting this section - no longer used
                     # dial-up 6.4.2.2.1.1.2.1 (lowbps) - lowest bits per second
                     # dial-up 6.4.2.2.1.1.2.2 (highbps) - highest bits per second
                     # dial-up 6.4.2.2.1.1.2.3 (numdata) - number of data bits
                     # dial-up 6.4.2.2.1.1.2.4 (numstop) - number of stop bits
                     # dial-up 6.4.2.2.1.1.2.5 (parity) - parity (odd, even, none)
                     # dial-up 6.4.2.2.1.1.2.6 (compress) - compression support
                     # dial-up 6.4.2.2.1.1.2.7 (dialtel) - dial-up number
                     # dial-up 6.4.2.2.1.1.2.8 (dialfile) - file name

                  end


                  # online option 6.4.2.2.1.2 (accinstr) - access instructions
                  # <- onlineOption.olResProtocol
                  unless hOnline[:olResProtocol].nil?
                     @xml.tag!('accinstr', hOnline[:olResProtocol])
                  end
                  if hOnline[:olResProtocol].nil?
                     @xml.tag!('accinstr')
                  end

                  # online option 6.4.2.2.1.3 (oncomp) - distribution computer make and operating system
                  # <- onlineOption.olResDesc
                  unless hOnline[:olResDesc].nil?
                     @xml.tag!('oncomp', hOnline[:olResDesc])
                  end
                  if hOnline[:olResDesc].nil?
                     @xml.tag!('oncomp')
                  end

               end # writeXML
            end # OnlineOption

         end
      end
   end
end
