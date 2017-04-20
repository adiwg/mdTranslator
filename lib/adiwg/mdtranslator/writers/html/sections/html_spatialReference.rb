# HTML writer
# spatial reference system

# History:
#  Stan Smith 2017-03-27 original script

require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_SpatialReference

               def initialize(html)
                  @html = html
               end

               def writeHtml(hSpaceRef)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)

                  # spatial reference - type
                  unless hSpaceRef[:systemType].nil?
                     @html.em('Reference System Type: ')
                     @html.text!(hSpaceRef[:systemType])
                     @html.br
                  end

                  # spatial reference - identifier {identifier}
                  unless hSpaceRef[:systemIdentifier].empty?
                     identifierClass.writeHtml(hSpaceRef[:systemIdentifier])
                  end

               end # writeHtml
            end # Html_SpatialReference

         end
      end
   end
end
