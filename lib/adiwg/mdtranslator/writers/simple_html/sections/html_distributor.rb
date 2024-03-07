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
         module Simple_html

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
                     @html.div do
                        @html.h5('Contact', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           responsibilityClass.writeHtml(hDistributor[:contact])
                        end
                     end
                  end

                  # distributor - order process [] {orderProcess}
                  hDistributor[:orderProcess].each do |hOrder|
                     @html.div do
                        @html.h5('Order Process', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           orderClass.writeHtml(hOrder)
                        end
                     end
                  end

                  # distributor - transfer options [] {transferOption}
                  hDistributor[:transferOptions].each do |hTransfer|
                     @html.div do
                        @html.h5('Transfer Option', {'class' => 'h5'})
                        @html.div(:class => 'block') do
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
