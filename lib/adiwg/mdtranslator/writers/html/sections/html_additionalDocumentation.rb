# HTML writer
# additional documentation

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlAdditionalDocumentation
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hAddDoc)

                        # classes used
                        htmlCitation = MdHtmlCitation.new(@html)

                        # additional documentation - resource type
                        s = hAddDoc[:resourceType]
                        if !s.nil?
                            @html.em('Resource type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # additional documentation - citation
                        hCitation = hAddDoc[:citation]
                        if !hCitation.empty?
                            @html.em('Citation: ')
                            @html.section(:class=>'block') do
                                htmlCitation.writeHtml(hCitation)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
