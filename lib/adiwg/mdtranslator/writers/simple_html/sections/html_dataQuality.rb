require_relative 'html_citation'
require_relative 'html_scope'
require_relative 'html_dataQualityReport'

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
            dataQualityReportClass = Html_DataQualityReport.new(@html)

            unless hDataQuality[:scope].empty?
              @html.div(class: 'block') do
                @html.div do
                  @html.h5('Scope', {'class' => 'h5'})
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
                  @html.h5('Standalone Quality Report', {'class' => 'h5'})
                  unless report[:abstract].nil?
                    @html.div(class: 'block') do
                      @html.em('Abstract:')
                      @html.text!(report[:abstract])
                    end
                  end

                  unless report[:reportReference].nil?
                    @html.div do
                      @html.h5('Report Reference', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        citationClass.writeHtml(report[:reportReference])
                      end
                    end
                  end

                end
              end
            end

            # reports
            unless hDataQuality[:report].empty?
              @html.div(class: 'block') do
                @html.div do
                  @html.h4('Reports', {'class' => 'h4'})
                  hDataQuality[:report].each do |report|
                    @html.div(class: 'block') do
                      @html.div do
                        @html.h5('Report', {'class' => 'h5'})
                        dataQualityReportClass.writeHtml(report)
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
