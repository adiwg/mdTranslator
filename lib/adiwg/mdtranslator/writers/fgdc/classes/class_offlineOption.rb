# FGDC <<Class>> OfflineOption
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-01-31 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class OfflineOption

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hOffline)

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
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Offline Option is missing media name'
                  end

                  # offline option 6.4.2.2.2.2 (reccap) - recording capacity (compound)
                  # <- hOffline.density and or hOffline.units
                  haveCapacity = false
                  haveCapacity = true unless hOffline[:density].nil?
                  haveCapacity = true unless hOffline[:units].nil?
                  if haveCapacity

                     # recording capacity 6.4.2.2.2.2.1 (recden) - recording density
                     unless hOffline[:density].nil?
                        @xml.tag!('recden', hOffline[:density])
                     end
                     if hOffline[:density].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('recden')
                     end

                     # recording capacity 6.4.2.2.2.2.2 (recdenu) - recording density units
                     unless hOffline[:units].nil?
                        @xml.tag!('recdenu', hOffline[:units])
                     end
                     if hOffline[:units].nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('recdenu')
                     end

                  end

                  # offline option 6.4.2.2.2.3 (recfmt) - recording format []
                  # <- hOffline.mediumFormat[]
                  hOffline[:mediumFormat].each do |format|
                     unless format == ''
                        @xml.tag!('recfmt', format)
                     end
                  end
                  if hOffline[:mediumFormat].empty?
                     @xml.tag!('recfmt')
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
