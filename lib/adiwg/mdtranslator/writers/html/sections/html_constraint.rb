# HTML writer
# constraint

# History:
#  Stan Smith 2017-03-30 original script

require_relative 'html_scope'
require_relative 'html_graphic'
require_relative 'html_citation'
require_relative 'html_responsibility'
require_relative 'html_releasability'
require_relative 'html_legalConstraint'
require_relative 'html_securityConstraint'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Constraint

               def initialize(html)
                  @html = html
               end

               def writeHtml(hConstraint)

                  # classes used
                  scopeClass = Html_Scope.new(@html)
                  graphicClass = Html_Graphic.new(@html)
                  citationClass = Html_Citation.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  releasabilityClass = Html_Releasability.new(@html)
                  legalClass = Html_LegalConstraint.new(@html)

                  # constraint - type
                  unless hConstraint[:type].nil?
                     @html.em('Constraint Type: ')
                     @html.text!(hConstraint[:type])
                     @html.br
                  end

                  # constraint - use limitation []
                  hConstraint[:useLimitation].each do |limitation|
                     @html.em('Limitation: ')
                     @html.section(:class => 'block') do
                        @html.text!(limitation)
                     end
                  end

                  # constraint - scope {scope}
                  unless hConstraint[:scope].empty?
                     @html.details do
                        @html.summary('Scope', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           scopeClass.writeHtml(hConstraint[:scope])
                        end
                     end
                  end

                  # constraint - graphic [] {graphic}
                  hConstraint[:graphic].each do |hGraphic|
                     @html.details do
                        @html.summary('Graphic', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           graphicClass.writeHtml(hGraphic)
                        end
                     end
                  end

                  # constraint - reference [] {citation}
                  hConstraint[:reference].each do |hReference|
                     @html.details do
                        @html.summary('Reference', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           citationClass.writeHtml(hReference)
                        end
                     end
                  end

                  # constraint - releasability {releasability}
                  unless hConstraint[:releasability].empty?
                     @html.details do
                        @html.summary('Releasability', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           releasabilityClass.writeHtml(hConstraint[:releasability])
                        end
                     end
                  end

                  # constraint - responsibility [] {responsibility}
                  hConstraint[:responsibleParty].each do |hResponsibility|
                     @html.details do
                        @html.summary(hResponsibility[:roleName], {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           responsibilityClass.writeHtml(hResponsibility)
                        end
                     end
                  end

                  # constraint - legal {legal constraint}
                  if hConstraint[:type] == 'legal' && !hConstraint[:legalConstraint].empty?
                     legalClass.writeHtml(hConstraint[:legalConstraint])
                  end

                  # constraint - security {security constraint}
                  if hConstraint[:type] == 'legal' && !hConstraint[:securityConstraint].empty?
                     secuirtyClass.writeHtml(hConstraint[:securityConstraint])
                  end

               end # writeHtml
            end # Html_Constraint

         end
      end
   end
end
