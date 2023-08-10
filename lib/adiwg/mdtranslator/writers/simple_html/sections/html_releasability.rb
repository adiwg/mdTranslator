# HTML writer
# releasability

# History:
#  Stan Smith 2017-03-31 original script

require_relative 'html_responsibility'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

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
                     @html.section(:class => 'block') do
                        @html.text!(hRelease[:statement])
                     end
                  end

                  # releasability - addressee [] {responsibility}
                  unless hRelease[:addressee].empty?
                     @html.details do
                        @html.summary('Applies to', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           hRelease[:addressee].each do |hAddressee|
                              @html.details do
                                 @html.summary(hAddressee[:roleName], 'class' => 'h5')
                                 @html.section(:class => 'block') do
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
