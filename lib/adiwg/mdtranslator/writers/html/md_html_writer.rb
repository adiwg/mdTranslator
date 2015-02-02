
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), './templates'))

require 'liquid'
require 'kramdown'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlWriter
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)

                        # set template namespace
                        $TempNS = ADIWG::Mdtranslator::Writers::Html

                        # the file_system must be declared to use templates
                        # changing the default naming style '_%s.liquid' to '_%s.md'
                        # path seems to need to be full path
                        tempPath = File.join(File.dirname(__FILE__), 'templates')
                        Liquid::Template.file_system = Liquid::LocalFileSystem.new(tempPath, '_%s.md')

                        # I put the starting liquid code in a variable since Ruby considers it an
                        # invalid structure.  Also 'parse()' does not accept a string
                        # Things I learned ...
                        # 1. can't mix html and markdown in a liquid module because kramdown get upset,
                        # ... so only use markdown for body; add on top and bottom
                        topTemp = "{%include 'top' %}"
                        bodyTemp = "{%include 'body' %}"
                        bottomTemp = "{%include 'bottom' %}"

                        sLiqTop = Liquid::Template.parse(topTemp).render()
                        sLiqBody = Liquid::Template.parse(bodyTemp).render(intObj)
                        sHtml= Kramdown::Document.new(sLiqBody).to_html
                        sLiqBottom = Liquid::Template.parse(bottomTemp).render()

                        sLiquid = sLiqTop + sHtml + sLiqBottom

                        require 'pp'
                        pp intObj

                        return sLiquid

                    end
                end

            end
        end
    end
end