require_relative 'html_citation'
require_relative 'html_dataQualityReport'
require_relative 'html_scope'

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

            # scope
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

            # standalone quality report
            unless hDataQuality[:standaloneReport].nil? || 
                   ( hDataQuality[:standaloneReport][:abstract].nil? && 
                     hDataQuality[:standaloneReport][:reportReference].nil? )
              report = hDataQuality[:standaloneReport]
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

            # reports
            unless hDataQuality[:report].nil? || hDataQuality[:report].empty?
              @html.section(class: 'block') do
                @html.details do
                  @html.summary('Reports', {'class' => 'h5'})
                  hDataQuality[:report].each do |report|
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
