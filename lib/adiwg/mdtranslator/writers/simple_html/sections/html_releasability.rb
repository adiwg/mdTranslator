# HTML writer
# releasability

# History:
#  Stan Smith 2017-03-31 original script

require_relative 'html_responsibility'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_Releasability

               def initialize(html)
                  @html = html
               end

               def writeHtml(hRelease)

                  # classes used
                  responsibilityClass = Html_Responsibility.new(@html)

                  # releasability - dissemination constraint {restrictionCode}
                  hRelease[:disseminationConstraint].each do |restriction|
                     @html.em('Dissemination Constraint Code: ')
                     @html.text!(restriction)
                     @html.br
                  end

                  # releasability - statement
                  unless hRelease[:statement].nil?
                     @html.em('Statement: ')
                     @html.div(:class => 'block') do
                        @html.text!(hRelease[:statement])
                     end
                  end

                  # releasability - addressee [] {responsibility}
                  unless hRelease[:addressee].empty?
                     @html.div do
                        @html.div('Applies to', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           hRelease[:addressee].each do |hAddressee|
                              @html.div do
                                 @html.div(hAddressee[:roleName], 'class' => 'h5')
                                 @html.div(:class => 'block') do
                                    responsibilityClass.writeHtml(hAddressee)
                                 end
                              end
                           end
                        end
                     end
                  end

               end # writeHtml
            end # Html_Releasability

         end
      end
   end
end
