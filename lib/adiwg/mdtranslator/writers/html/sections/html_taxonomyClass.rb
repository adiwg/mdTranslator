# HTML writer
# resource specific usage

# History:
# 	Stan Smith 2015-03-25 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlTaxonomyClass
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(aTaxClass)

                        hTaxonCl = aTaxClass[0]

                        @html.blockquote do

                            # taxonomic class - taxonomic rank
                            s = hTaxonCl[:taxRankName]
                            if !s.nil?
                                @html.em('Taxonomic Rank: ')
                                @html.text!(s)
                                @html.br
                            end

                            # taxonomic class - taxonomic value
                            s = hTaxonCl[:taxRankValue]
                            if !s.nil?
                                @html.em('Taxonomic Value: ')
                                @html.text!(s)
                                @html.br
                            end

                            # taxonomic class - common name
                            s = hTaxonCl[:commonName]
                            if !s.nil?
                                @html.em('Common name: ')
                                @html.text!(s)
                                @html.br
                            end

                            # taxon class - classification - recursive
                            aTaxClass.slice!(0)
                            unless aTaxClass.empty?
                                writeHtml(aTaxClass)
                            end

                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
