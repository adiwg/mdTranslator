# HTML writer
# funding

# History:
#  Stan Smith 2017-08-31 refactored for mdJson 2.3 schema update
#  Stan Smith 2017-04-04 original script

require_relative 'html_allocation'
require_relative 'html_temporalExtent'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Funding

               def initialize(html)
                  @html = html
               end

               def writeHtml(hFunding)

                  # classes used
                  allocationClass = Html_Allocation.new(@html)
                  temporalClass = Html_TemporalExtent.new(@html)

                  # funding - description
                  unless hFunding[:description].nil?
                     @html.em('Description:')
                     @html.section(:class => 'block') do
                        @html.text!(hFunding[:description])
                     end
                  end

                  # funding - timePeriod {timePeriod}
                  unless hFunding[:timePeriod].empty?
                     temporalObj = {}
                     temporalObj[:timeInstant] = {}
                     temporalObj[:timePeriod] = hFunding[:timePeriod]
                     temporalClass.writeHtml(temporalObj)
                  end

                  # funding - allocations [] {allocation}
                  hFunding[:allocations].each do |hAllocation|
                     @html.details do
                        @html.summary('Allocation', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           allocationClass.writeHtml(hAllocation)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Funding

         end
      end
   end
end
