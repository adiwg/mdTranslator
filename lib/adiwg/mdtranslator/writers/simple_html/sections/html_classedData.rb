# HTML writer
# classed data

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_classedDataItem'

module ADIWG
    module Mdtranslator
        module Writers
            module Simple_html

                class MdHtmlClassedData
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hClassD)

                        # classes used
                        htmlClassItem = MdHtmlClassedDataItem.new(@html)

                        # classed data - number of classes
                        s = hClassD[:numberOfClasses]
                        if !s.nil?
                            @html.em('Number of classes: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # classed data - data items
                        aClassItems = hClassD[:classedDataItems]
                        aClassItems.each do |hClassItem|
                            @html.div do
                                @html.h5(hClassItem[:className], {'class'=>'h5'})
                                @html.div(:class=>'block') do
                                    htmlClassItem.writeHtml(hClassItem)
                                end
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
