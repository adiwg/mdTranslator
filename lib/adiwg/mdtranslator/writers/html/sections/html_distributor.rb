# HTML writer
# resource distributor

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_responsibility'
require_relative 'html_orderProcess'
require_relative 'html_format'
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

                  @html.text!('Nothing Here')

                  # classes used
                  responsibilityClass = Html_Responsibility.new(@html)
                  orderClass = Html_OrderProcess.new(@html)
                  formatClass = Html_Format.new(@html)
                  transferClass = Html_TransferOption.new(@html)

                  # # resource distribution - distributor - required
                  # @html.em('Distributor contact: ')
                  # hResParty = hDistributor[:distContact]
                  # @html.section(:class => 'block') do
                  #    responsibilityClass.writeHtml(hResParty)
                  # end
                  #
                  # # resource distribution - order process
                  # hDistributor[:distOrderProcs].each do |hOrder|
                  #    @html.em('Order Process: ')
                  #    @html.section(:class => 'block') do
                  #       htmlOrderProc.writeHtml(hOrder)
                  #    end
                  # end
                  #
                  # # resource distribution - resource format
                  # hDistributor[:distFormats].each do |hFormat|
                  #    htmlFormat.writeHtml(hFormat)
                  # end
                  #
                  # # resource distribution - transfer options
                  # hDistributor[:distTransOptions].each do |hTransOption|
                  #    htmlTranOpt.writeHtml(hTransOption)
                  # end

               end # writeHtml
            end # Html_Distributor

         end
      end
   end
end
