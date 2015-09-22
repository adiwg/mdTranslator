# HTML writer
# resource distributor

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_responsibleParty'
require_relative 'html_orderProcess'
require_relative 'html_format'
require_relative 'html_transferOption'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlDistributor
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hDistributor)

                        # classes used
                        htmlResParty = MdHtmlResponsibleParty.new(@html)
                        htmlOrderProc = MdHtmlOrderProcess.new(@html)
                        htmlFormat = MdHtmlFormat.new(@html)
                        htmlTranOpt = MdHtmlTransferOption.new(@html)

                        # resource distribution - distributor - required
                        @html.em('Distributor contact: ')
                        hResParty = hDistributor[:distContact]
                        @html.section(:class=>'block') do
                            htmlResParty.writeHtml(hResParty)
                        end

                        # resource distribution - order process
                        hDistributor[:distOrderProcs].each do |hOrder|
                            @html.em('Order Process: ')
                            @html.section(:class=>'block') do
                                htmlOrderProc.writeHtml(hOrder)
                            end
                        end

                        # resource distribution - resource format
                        hDistributor[:distFormats].each do |hFormat|
                            htmlFormat.writeHtml(hFormat)
                        end

                        # resource distribution - transfer options
                        hDistributor[:distTransOptions].each do |hTransOption|
                            htmlTranOpt.writeHtml(hTransOption)
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
