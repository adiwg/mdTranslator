# HTML writer
# taxonomy

# History:
# 	Stan Smith 2015-03-25 original script

require 'html_citation'
require 'html_responsibleParty'
require 'html_taxonomyClass'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlTaxonomy
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hTaxon)

                        # classes used
                        htmlCitation = $HtmlNS::MdHtmlCitation.new(@html)
                        htmlRParty = $HtmlNS::MdHtmlResponsibleParty.new(@html)
                        htmlTaxClass = $HtmlNS::MdHtmlTaxonomyClass.new(@html)

                        # taxonomy - taxonomic class system - citation
                        aTaxSys = hTaxon[:taxClassSys]
                        if !aTaxSys.empty?
                            @html.em('Taxonomic class system: ')
                            aTaxSys.each do |hCitation|
                                @html.blockquote do
                                    htmlCitation.writeHtml(hCitation)
                                end
                            end
                        end

                        # taxonomy - taxonomic general scope
                        s = hTaxon[:taxGeneralScope]
                        if !s.nil?
                            @html.em('General scope: ')
                            @html.text!(s)
                            @html.br
                        end

                        # taxonomy - taxonomic observers - responsible party
                        aTaxObs = hTaxon[:taxObservers]
                        if !aTaxObs.empty?
                            @html.em('Taxonomic observer: ')
                            aTaxObs.each do |hResParty|
                                @html.blockquote do
                                    htmlRParty.writeHtml(hResParty)
                                end
                            end
                        end

                        # taxonomy - taxonomic identification procedures
                        s = hTaxon[:taxIdProcedures]
                        if !s.nil?
                            @html.em('Taxonomic identification procedures: ')
                            @html.text!(s)
                            @html.br
                        end

                        # taxonomy - taxonomic voucher
                        # note: should be an array according to ISO docs,
                        # but NOAA 19115_2 XSD does not allow
                        #     specimen: nil,
                        #     repository: {}
                        hTaxVoucher = hTaxon[:taxVoucher]
                        if !hTaxVoucher.empty?

                            # taxonomic voucher - specimen
                            s = hTaxVoucher[:specimen]
                            if !s.nil?
                                @html.em('Specimen: ')
                                @html.text!(s)
                                @html.br
                            end

                            # taxonomic voucher - repository - responsible party
                            hResParty = hTaxVoucher[:repository]
                            if !hResParty.empty?
                            @html.em('Specimen repository: ')
                                @html.blockquote do
                                    htmlRParty.writeHtml(hResParty)
                                end
                            end
                        end

                        # taxonomy - taxonomic class - array
                        aTaxClass = hTaxon[:taxClasses]
                        if !aTaxClass.empty?
                            @html.em('Taxonomic class structure: ')
                            htmlTaxClass.writeHtml(aTaxClass)
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
