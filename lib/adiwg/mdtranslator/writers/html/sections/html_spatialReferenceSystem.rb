# HTML writer
# spatial reference system

# History:
# 	Stan Smith 2015-03-25 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlSpatialReferenceSystem
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hSpaceRef)

                        # spatial reference system - names
                        aNames = hSpaceRef[:sRNames]
                        if !aNames.empty?
                            aNames.each do |sRName|
                                @html.em('Spatial reference system name: ')
                                @html.text!(sRName)
                                @html.br
                            end
                        end

                        # spatial reference system - EPSGs
                        # European Petroleum Survey Group - EPSG
                        aEPSG = hSpaceRef[:sREPSGs]
                        if !aEPSG.empty?
                            aEPSG.each do |nREPSG|
                                @html.em('EPSG Geodetic Parameter Dataset: ')
                                @html.text!(nREPSG.to_s)
                                @html.br
                            end
                        end

                        # spatial reference system - well know text
                        aWKT = hSpaceRef[:sRWKTs]
                        if !aWKT.empty?
                            aWKT.each do |sRWKT|
                                @html.em('Well-Know-Text: ')
                                @html.section(:class=>'block') do
                                    @html.text!(sRWKT)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
