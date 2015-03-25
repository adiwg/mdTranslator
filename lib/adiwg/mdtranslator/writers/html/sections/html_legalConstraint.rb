# HTML writer
# legal constraint

# History:
# 	Stan Smith 2015-03-24 original script

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlLegalConstraint
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hLegalCon)

                        # legal constraint - access constraints
                        aAccess = hLegalCon[:accessCodes]
                        if !aAccess.empty?
                            aAccess.each do |aCon|
                                @html.em('Access constraint: ')
                                @html.text!(aCon)
                                @html.br
                            end
                        end

                        # legal constraint - use constraints
                        aUse = hLegalCon[:useCodes]
                        if !aUse.empty?
                            aUse.each do |useCon|
                                @html.em('Use constraint: ')
                                @html.text!(useCon)
                                @html.br
                            end
                        end

                        # legal constraint - other constraints
                        aOther = hLegalCon[:otherCons]
                        if !aOther.empty?
                            aOther.each do |otherCon|
                                @html.em('Other constraint: ')
                                @html.text!(otherCon)
                                @html.br
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
