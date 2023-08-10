# HTML writer
# citation

# History:
#  Stan Smith 2017-03-23 refactored for mdTranslator 2.0
# 	Stan Smith 2015-03-23 original script
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
#  Stan Smith 2015-08-26 added alternate title

require_relative 'html_date'
require_relative 'html_responsibility'
require_relative 'html_identifier'
require_relative 'html_onlineResource'
require_relative 'html_graphic'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_Citation

               def initialize(html)
                  @html = html
               end

               def writeHtml(hCitation)

                  # classes used
                  dateClass = Html_Date.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)
                  identifierClass = Html_Identifier.new(@html)
                  onlineClass = Html_OnlineResource.new(@html)
                  graphicClass = Html_Graphic.new(@html)

                  # citation - title
                  @html.em('Title: ')
                  unless hCitation[:title].nil?
                     @html.text!(hCitation[:title])
                  else
                     @html.text!('*MISSING*')
                  end
                  @html.br

                  # citation - alternate title
                  unless hCitation[:alternateTitles].empty?
                     hCitation[:alternateTitles].each do |altTitle|
                        @html.em('Alternate title: ')
                        @html.text!(altTitle)
                        @html.br
                     end
                  end

                  # citation - date [] {}
                  hCitation[:dates].each do |hDate|
                     @html.em('Date: ')
                     dateClass.writeHtml(hDate)
                     @html.br
                  end

                  # citation - edition
                  unless hCitation[:edition].nil?
                     @html.em('Edition: ')
                     @html.text!(hCitation[:edition])
                     @html.br
                  end

                  # citation - responsibilities [] {responsibility}
                  hCitation[:responsibleParties].each do |hResponsibility|
                     @html.div do
                        @html.div(hResponsibility[:roleName], 'class' => 'h5')
                        @html.div(:class => 'block') do
                           responsibilityClass.writeHtml(hResponsibility)
                        end
                     end
                  end

                  # citation - identifier []
                  hCitation[:identifiers].each do |hIdentifier|
                     @html.div do
                        @html.div('Identifier', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hIdentifier)
                        end
                     end
                  end

                  # citation - series
                  unless hCitation[:series].empty?
                     @html.div do
                        @html.div('Publication Series', {'class' => 'h5'})
                        @html.div(:class => 'block') do

                           hSeries = hCitation[:series]

                           # series - name
                           unless hSeries[:seriesName].nil?
                              @html.em('Series Name: ')
                              @html.text!(hSeries[:seriesName])
                              @html.br
                           end

                           # series - issue
                           unless hSeries[:seriesIssue].nil?
                              @html.em('Series Issue: ')
                              @html.text!(hSeries[:seriesIssue])
                              @html.br
                           end

                           # series - page
                           unless hSeries[:issuePage].nil?
                              @html.em('Issue Page: ')
                              @html.text!(hSeries[:issuePage])
                              @html.br
                           end

                        end
                     end
                  end

                  # citation - online resource []
                  hCitation[:onlineResources].each do |hOnline|
                     @html.div do
                        @html.div('Online Resource', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           onlineClass.writeHtml(hOnline)
                        end
                     end
                  end

                  # citation - browse graphic []
                  hCitation[:browseGraphics].each do |hGraphic|
                     @html.div do
                        @html.div('Graphic Overview', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           graphicClass.writeHtml(hGraphic)
                        end
                     end
                  end

                  # citation - presentation form []
                  unless hCitation[:presentationForms].empty?
                     hCitation[:presentationForms].each do |forms|
                        @html.em('Presentation Form: ')
                        @html.text!(forms)
                        @html.br
                     end
                  end

                  # citation - other div []
                  unless hCitation[:otherdiv].empty?
                     hCitation[:otherdiv].each do |detail|
                        @html.em('Other div: ')
                        @html.text!(detail)
                        @html.br
                     end
                  end

               end # writeHtml
            end # Html_Citation

         end
      end
   end
end
