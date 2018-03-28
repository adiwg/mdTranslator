# FGDC <<Class>> OfflineOption
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-16 refactored error and warning messaging
#  Stan Smith 2018-01-31 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class OfflineOption

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hOffline, inContext)

                  # offline option 6.4.2.2.2.1 (offmedia) - offline media name (required)
                  # <- hOffline.mediaSpecification.title
                  haveTitle = false
                  unless hOffline[:mediumSpecification].empty?
                     unless hOffline[:mediumSpecification][:title].nil?
                        @xml.tag!('offmedia', hOffline[:mediumSpecification][:title])
                        haveTitle = true
                     end
                  end
                  unless haveTitle
                     @NameSpace.issueWarning(120,'offmedia', inContext)
                  end

                  # offline option 6.4.2.2.2.2 (reccap) - recording capacity (compound)
                  # <- hOffline.density and or hOffline.units
                  haveCapacity = false
                  haveCapacity = true unless hOffline[:density].nil?
                  haveCapacity = true unless hOffline[:units].nil?
                  if haveCapacity
                     @xml.tag!('reccap') do

                        # recording capacity 6.4.2.2.2.2.1 (recden) - recording density (required)
                        unless hOffline[:density].nil?
                           @xml.tag!('recden', hOffline[:density])
                        end
                        if hOffline[:density].nil?
                           @NameSpace.issueWarning(121,'recden', inContext)
                        end

                        # recording capacity 6.4.2.2.2.2.2 (recdenu) - recording density units (required)
                        unless hOffline[:units].nil?
                           @xml.tag!('recdenu', hOffline[:units])
                        end
                        if hOffline[:units].nil?
                           @NameSpace.issueWarning(122,'recdenu', inContext)
                        end

                     end
                  end

                  # offline option 6.4.2.2.2.3 (recfmt) - recording format [] (required)
                  # <- hOffline.mediumFormat[]
                  hOffline[:mediumFormat].each do |format|
                     unless format == ''
                        @xml.tag!('recfmt', format)
                     end
                  end
                  if hOffline[:mediumFormat].empty?
                     @NameSpace.issueWarning(123,'recfmt', inContext)
                  end

                  # offline option 6.4.2.2.2.4 (compat) - compatibility information
                  # <- hOffline.note
                  unless hOffline[:note].nil?
                     @xml.tag!('compat', hOffline[:note])
                  end
                  if hOffline[:note].nil? && @hResponseObj[:writerShowTags]
                     @xml.tag!('compat')
                  end

               end # writeXML
            end # OfflineOption

         end
      end
   end
end
