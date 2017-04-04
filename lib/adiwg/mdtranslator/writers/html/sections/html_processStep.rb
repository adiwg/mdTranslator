# HTML writer
# process step

# History:
#  Stan Smith 2017-04-03 refactored for mdTranslator 2.0
#  Stan Smith 2015-07-16 refactored to remove global namespace $HtmlNS
# 	Stan Smith 2015-03-27 original script

require_relative 'html_datetime'
require_relative 'html_responsibility'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_ProcessStep

               def initialize(html)
                  @html = html
               end

               def writeHtml(hStep)

                  # classes used
                  datetimeClass = Html_Datetime.new(@html)
                  responsibilityClass = Html_Responsibility.new(@html)

                  @html.em('Nothing yet')

                  # # process step - id
                  # s = hStep[:stepId]
                  # if !s.nil?
                  #    @html.em('Step ID: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # process step - description
                  # s = hStep[:stepDescription]
                  # if !s.nil?
                  #    @html.em('Description: ')
                  #    @html.section(:class => 'block') do
                  #       @html.text!(s)
                  #    end
                  # end
                  #
                  # # process step - step rationale
                  # s = hStep[:stepRationale]
                  # if !s.nil?
                  #    @html.em('Rationale: ')
                  #    @html.text!(s)
                  #    @html.br
                  # end
                  #
                  # # process step - dateTime
                  # hDateTime = hStep[:stepDateTime]
                  # if !hDateTime.empty?
                  #    @html.em('DateTime: ')
                  #    datetimeClass.writeHtml(hDateTime)
                  # end
                  #
                  # # process step - processors
                  # aProcessor = hStep[:stepProcessors]
                  # aProcessor.each do |hResParty|
                  #    @html.em('Responsible party: ')
                  #    @html.section(:class => 'block') do
                  #       responsibilityClass.writeHtml(hResParty)
                  #    end
                  # end

               end # writeHtml
            end # Html_ProcessStep

         end
      end
   end
end
