# HTML writer
# geologic age

# History:
#  Stan Smith 2017-11-09 original script

require_relative 'html_citation'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_GeologicAge

               def initialize(html)
                  @html = html
               end

               def writeHtml(hGeoAge)

                  # classes used
                  citationClass = Html_Citation.new(@html)

                  # geologic age - age time scale
                  unless hGeoAge[:ageTimeScale].nil?
                     @html.em('Age Time Scale: ')
                     @html.text!(hGeoAge[:ageTimeScale])
                     @html.br
                  end

                  # geologic age - age estimate
                  unless hGeoAge[:ageEstimate].nil?
                     @html.em('Age Estimate: ')
                     @html.text!(hGeoAge[:ageEstimate])
                     @html.br
                  end

                  # geologic age - age uncertainty
                  unless hGeoAge[:ageUncertainty].nil?
                     @html.em('Age Uncertainty: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeoAge[:ageUncertainty])
                     end
                  end

                  # geologic age - age explanation
                  unless hGeoAge[:ageExplanation].nil?
                     @html.em('Age Determination Methodology: ')
                     @html.div(:class => 'block') do
                        @html.text!(hGeoAge[:ageExplanation])
                     end
                  end

                  # geologic age - age references [] {citation}
                  hGeoAge[:ageReferences].each do |hCitation|
                     @html.div do
                        @html.div('Age Reference', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           citationClass.writeHtml(hCitation)
                        end
                     end
                  end

               end # writeHtml
            end # Html_GeologicAge

         end
      end
   end
end
