require_relative 'html_citation'
require_relative 'html_dataQualityReport'

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
            scopeClass = Html_Scope.new(@html)
            dataQualityReportClass = Html_DataQualityReport.new(@html)

            unless hDataQuality[:scope].nil? || hDataQuality[:scope].empty?
              @html.section(class: 'block') do
                @html.details do
                  @html.summary('Scope', {'class' => 'h5'})
                  @html.section(class: 'block') do
                    scopeClass.writeHtml(hDataQuality[:scope])
                  end
                end
              end
            end


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


            unless report[:reports].nil? || report[:reports].empty?
              @html.section(class: 'block') do
                @html.details do
                  @html.summary('Reports', {'class' => 'h5'})
                  report[:reports].each do |report|
                    @html.section(class: 'block') do
                      @html.details do
                        @html.summary('Report', {'class' => 'h5'})
                        @html.section(class: 'block') do
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
end
