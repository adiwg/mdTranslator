# FGDC <<Class>> Publisher
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2018-03-23 refactored error and warning messaging
#  Stan Smith 2017-11-21 original script

require_relative '../fgdc_writer'

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Publisher

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Fgdc
               end

               def writeXML(hContact)

                  # publication 8.8.1 (pubplace) - publication place
                  # <- hContact[:addresses][:description] (required)
                  place = ''
                  unless hContact[:addresses].empty?
                     hAddress = hContact[:addresses][0]
                     unless hAddress.empty?
                        description = hAddress[:description]
                        city = hAddress[:city]
                        state = hAddress[:adminArea]
                        country = hAddress[:country]
                        place = ''
                        place += city unless city.nil?
                        place += ', ' + state unless state.nil?
                        place += ', ' + country unless country.nil?
                        if place.empty?
                           unless description.nil?
                              place = description
                           end
                        end
                     end
                     unless place.empty?
                        @xml.tag!('pubplace', place)
                     end
                  end
                  if place == ''
                     @NameSpace.issueWarning(330, 'pubplace', 'identification information citation')
                  end

                  # publication 8.8.2 (publish) - publisher name
                  # <- hContact[:name] (required)
                  name = hContact[:name]
                  unless name.nil?
                     @xml.tag!('publish', name)
                  end
                  if name.nil?
                     @NameSpace.issueWarning(331, 'publish', 'identification information citation')
                  end

               end # writeXML
            end # Series

         end
      end
   end
end
