require_relative 'html_citation'

module ADIWG
  module Mdtranslator
    module Writers
      module Html
        class Html_DataQuality
          def initialize(html)
            @html = html
          end

          def writeHtml(hDataQuality)
            citationClass = Html_Citation.new(@html)

            unless hDataQuality[:standaloneQualityReport].nil? || 
                   ( hDataQuality[:standaloneQualityReport][:abstract].nil? && 
                     hDataQuality[:standaloneQualityReport][:reportReference].nil? )
              report = hDataQuality[:standaloneQualityReport]

              @html.section(class: 'block') do
                @html.details do
                  @html.summary('Standalone Quality Report', {'class' => 'h5'})
                  unless report[:abstract].nil?
                    @html.section(class: 'block') do
                      @html.em('Abstract:')
                      @html.text!(report[:abstract])
                    end
                  end

                  unless report[:reportReference].nil?
                    @html.details do
                      @html.summary('Report Reference', {'class' => 'h5'})
                      @html.section(class: 'block') do
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
