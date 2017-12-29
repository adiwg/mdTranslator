# FGDC <<Class>> Status
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-11-25 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Status

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hResourceInfo)

                  status = nil
                  status = hResourceInfo[:status][0] unless hResourceInfo[:status].empty?
                  frequency = nil
                  frequency = hResourceInfo[:resourceMaintenance][0][:frequency] unless hResourceInfo[:resourceMaintenance].empty?

                  # status 1.4 (status) - resource status
                  unless status.nil? && frequency.nil?
                     @xml.tag!('status') do

                        # status 1.4.1 (progress) - status (required)
                        # <- hResourceInfo[:status][0]
                        unless status.nil?
                           @xml.tag!('progress', status)
                        end
                        if status.nil?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Status section missing progress'
                        end

                        # status 1.4.2 (update) - maintenance and update frequency (required)
                        # <- hResourceInfo[:resourceMaintenance][:frequency]
                        unless frequency.nil?
                           @xml.tag!('update', frequency)
                        end
                        if frequency.nil?
                           @hResponseObj[:writerPass] = false
                           @hResponseObj[:writerMessages] << 'Status section missing maintenance frequency'
                        end

                     end
                  end
                  if status.nil? && frequency.nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Identification section missing status section'
                  end

               end # writeXML
            end # Status

         end
      end
   end
end
