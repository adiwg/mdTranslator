# FGDC <<Class>> Publisher
# FGDC CSDGM writer output in XML

# History:
#  Stan Smith 2017-11-21 original script

module ADIWG
   module Mdtranslator
      module Writers
         module Fgdc

            class Publisher

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
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
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Publisher is missing place of publication'
                  end

                  # publication 8.8.2 (publish) - publisher name
                  # <- hContact[:name] (required)
                  name = hContact[:name]
                  unless name.nil?
                     @xml.tag!('publish', name)
                  end
                  if name.nil?
                     @hResponseObj[:writerPass] = false
                     @hResponseObj[:writerMessages] << 'Publisher is missing name of publisher'
                  end

               end # writeXML
            end # Series

         end
      end
   end
end
