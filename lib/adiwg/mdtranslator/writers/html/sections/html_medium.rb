# HTML writer
# medium

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
#  Stan Smith 2015-09-21 added medium capacity
# 	Stan Smith 2015-03-27 original script

require_relative 'html_citation'
require_relative 'html_identifier'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Medium

               def initialize(html)
                  @html = html
               end

               def writeHtml(hMedium)

                  # classes used
                  citationClass = Html_Citation.new(@html)
                  identifierClass = Html_Identifier.new(@html)

                  # medium - specification {citation}
                  unless hMedium[:mediumSpecification].empty?
                     @html.details do
                        @html.summary('Medium Specification', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hMedium[:mediumSpecification])
                        end
                     end
                  end

                  # medium - density
                  unless hMedium[:density].nil?
                     @html.em('Density')
                     @html.text!(hMedium[:density].to_s)
                     @html.br
                  end

                  # medium - units
                  unless hMedium[:units].nil?
                     @html.em('Units')
                     @html.text!(hMedium[:units])
                     @html.br
                  end

                  # medium - number of volumes
                  unless hMedium[:numberOfVolumes].nil?
                     @html.em('Number of Volumes in Distribution Package')
                     @html.text!(hMedium[:numberOfVolumes].to_s)
                     @html.br
                  end

                  # medium - format []
                  hMedium[:mediumFormat].each do |format|
                     @html.em('Medium Format: ')
                     @html.text!(format)
                     @html.br
                  end

                  # medium - note
                  unless hMedium[:note].nil?
                     @html.em('Note')
                     @html.text!(hMedium[:note])
                     @html.br
                  end

                  # medium - identifier {identifier}
                  unless hMedium[:identifier].empty?
                     @html.details do
                        @html.summary('Identifier for the Medium', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           identifierClass.writeHtml(hMedium[:identifier])
                        end
                     end
                  end

               end # writeHtml
            end # Html_Medium

         end
      end
   end
end
