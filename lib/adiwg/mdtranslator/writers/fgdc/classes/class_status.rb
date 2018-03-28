# FGDC <<Class>> Status
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-26 refactored error and warning messaging
#  Stan Smith 2017-11-25 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Status

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hResourceInfo)

                  status = nil
                  status = hResourceInfo[:status][0] unless hResourceInfo[:status].empty?
                  frequency = nil
                  frequency = hResourceInfo[:resourceMaintenance][0][:frequency] unless hResourceInfo[:resourceMaintenance].empty?

                  # status 1.4 (status) - resource status (required)
                  unless status.nil? && frequency.nil?
                     @xml.tag!('status') do

                        # status 1.4.1 (progress) - status (required)
                        # <- hResourceInfo[:status][0]
                        unless status.nil?
                           @xml.tag!('progress', status)
                        end
                        if status.nil?
                           @NameSpace.issueWarning(390, 'progress', 'status section')
                        end

                        # status 1.4.2 (update) - maintenance and update frequency (required)
                        # <- hResourceInfo[:resourceMaintenance][:frequency]
                        unless frequency.nil?
                           @xml.tag!('update', frequency)
                        end
                        if frequency.nil?
                           @NameSpace.issueWarning(391, 'update', 'status section')
                        end

                     end
                  end
                  if status.nil? && frequency.nil?
                     @NameSpace.issueError(392, 'identification section')
                  end

               end # writeXML
            end # Status

         end
      end
   end
end
