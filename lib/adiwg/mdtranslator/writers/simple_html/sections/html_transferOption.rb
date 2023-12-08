# HTML writer
# transfer option

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
#  Stan Smith 2015-09-21 added transfer size elements
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_onlineResource'
require_relative 'html_medium'
require_relative 'html_duration'
require_relative 'html_format'

module ADIWG
   module Mdtranslator
      module Writers
         module Simple_html

            class Html_TransferOption

               def initialize(html)
                  @html = html
               end

               def writeHtml(hOption)

                  # classes used
                  onlineClass = Html_OnlineResource.new(@html)
                  mediumClass = Html_Medium.new(@html)
                  durationClass = Html_Duration.new(@html)
                  formatClass = Html_Format.new(@html)

                  # transfer options - units of distribution
                  unless hOption[:unitsOfDistribution].nil?
                     @html.em('Units of Distribution: ')
                     @html.text!(hOption[:unitsOfDistribution].to_s)
                     @html.br
                  end

                  # transfer options - transfer size
                  unless hOption[:transferSize].nil?
                     @html.em('Size of Unit in MB: ')
                     @html.text!(hOption[:transferSize].to_s)
                     @html.br
                  end

                  # transfer options - online options [] {onlineResource}
                  hOption[:onlineOptions].each do |hOption|
                     @html.div do
                        @html.div('Online Option', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           onlineClass.writeHtml(hOption)
                        end
                     end
                  end

                  # transfer options - offline options [] {medium}
                  hOption[:offlineOptions].each do |hOption|
                     @html.div do
                        @html.div('Offline Option', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           mediumClass.writeHtml(hOption)
                        end
                     end
                  end

                  # transfer options - transfer frequency {duration}
                  unless hOption[:transferFrequency].empty?
                     @html.div do
                        @html.div('Transfer Frequency', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           durationClass.writeHtml(hOption[:transferFrequency])
                        end
                     end
                  end

                  # transfer options - distribution formats [] {format}
                  hOption[:distributionFormats].each do |hFormat|
                     @html.div do
                        @html.div('Distribution Format Option', 'class' => 'h5')
                        @html.div(:class => 'block') do
                           formatClass.writeHtml(hFormat)
                        end
                     end
                  end

               end # writeHtml
            end # Html_TransferOption

         end
      end
   end
end
