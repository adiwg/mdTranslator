# HTML writer
# distributor

# History:
#  Stan Smith 2017-04-04 refactored for mdTranslator 2.0
# 	Stan Smith 2015-08-21 original script

require_relative 'html_responsibility'
require_relative 'html_orderProcess'
require_relative 'html_transferOption'

module ADIWG
   module Mdtranslator
      module Writers
         module Html

            class Html_Distributor

               def initialize(html)
                  @html = html
               end

               def writeHtml(hDistributor)

                  # classes used
                  responsibilityClass = Html_Responsibility.new(@html)
                  orderClass = Html_OrderProcess.new(@html)
                  transferClass = Html_TransferOption.new(@html)

                  # distributor - contact {responsibility}
                  unless hDistributor[:contact].empty?
                     @html.details do
                        @html.summary('Contact', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           responsibilityClass.writeHtml(hDistributor[:contact])
                        end
                     end
                  end

                  # distributor - order process [] {orderProcess}
                  hDistributor[:orderProcess].each do |hOrder|
                     @html.details do
                        @html.summary('Order Process', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           orderClass.writeHtml(hOrder)
                        end
                     end
                  end

                  # distributor - transfer options [] {transferOption}
                  hDistributor[:transferOptions].each do |hTransfer|
                     @html.details do
                        @html.summary('Transfer Option', {'class' => 'h5'})
                        @html.section(:class => 'block') do
                           transferClass.writeHtml(hTransfer)
                        end
                     end
                  end

               end # writeHtml
            end # Html_Distributor

         end
      end
   end
end
