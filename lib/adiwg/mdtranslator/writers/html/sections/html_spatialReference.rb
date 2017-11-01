# HTML writer
# spatial reference system

# History:
#  Stan Smith 2017-10-24 add reference system parameter set
#  Stan Smith 2017-03-27 original script

require_relative 'html_identifier'
require_relative 'html_referenceSystemParameters'

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
                  paramSetClass = Html_ReferenceSystemParameters.new(@html)

                  # spatial reference - type
                  unless hSpaceRef[:systemType].nil?
                     @html.em('Reference System Type: ')
                     @html.text!(hSpaceRef[:systemType])
                     @html.br
                  end

                  # spatial reference - identifier {identifier}
                  unless hSpaceRef[:systemIdentifier].empty?
                     @html.details do
                        @html.summary('System Identifier', {'id' => 'spatialReference-identifier', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hSpaceRef[:systemIdentifier])
                        end
                     end
                  end

                  # spatial reference - projection parameters {referenceSystemParameterSet}
                  unless hSpaceRef[:systemParameterSet].empty?
                     @html.details do
                        @html.summary('System Parameters', {'id' => 'spatialReference-parameters', 'class' => 'h5'})
                        @html.section(:class => 'block') do
                           paramSetClass.writeHtml(hSpaceRef[:systemParameterSet])
                        end
                     end
                  end

               end # writeHtml
            end # Html_SpatialReference

         end
      end
   end
end
