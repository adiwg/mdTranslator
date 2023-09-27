require_relative 'html_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module Simple_html
        class Html_DataQuality
          def initialize(html)
            @html = html
          end

          def writeHtml(hDataQuality)
            citationClass = Html_Citation.new(@html)
            scopeClass = Html_Scope.new(@html)

            unless hDataQuality[:scope].nil? || hDataQuality[:scope].empty?
              @html.div(class: 'block') do
                @html.div do
                  @html.div('Scope', {'class' => 'h5'})
                  @html.div(class: 'block') do
                    scopeClass.writeHtml(hDataQuality[:scope])
                  end
                end
              end
            end


            unless hDataQuality[:standaloneQualityReport].nil? || 
                   ( hDataQuality[:standaloneQualityReport][:abstract].nil? && 
                     hDataQuality[:standaloneQualityReport][:reportReference].nil? )
              report = hDataQuality[:standaloneQualityReport]

              @html.div(class: 'block') do
                @html.div do
                  @html.div('Standalone Quality Report', {'class' => 'h5'})
                  unless report[:abstract].nil?
                    @html.div(class: 'block') do
                      @html.em('Abstract:')
                      @html.text!(report[:abstract])
                    end
                  end

                  unless report[:reportReference].nil?
                    @html.div do
                      @html.div('Report Reference', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        citationClass.writeHtml(report[:reportReference])
                      end
                    end
                  end
                end
              end

            end
          end
        end
      end
    end
  end
end
