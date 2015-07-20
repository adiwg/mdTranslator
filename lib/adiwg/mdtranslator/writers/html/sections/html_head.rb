# HTML writer
# html head

# History:
# 	Stan Smith 2015-03-23 original script
#   Stan Smith 2015-04-07 added metadata tag to head
#   Stan Smith 2015-07-17 added support for user supplied css
#   Stan Smith 2015-07-20 moved mdTranslator logo to html_inlineCss.css

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlHead
                    def initialize(html, paramsObj)
                        @html = html
                        @paramsObj = paramsObj
                    end

                    def writeHtml()
                        @html.head do
                            @html.meta({'http-equiv'=>'Content-Type', 'content'=>'text/html; charset=utf-8'})
                            @html.title('HTML Metadata report')
                            @html.meta('name'=>'generator', 'content'=>'constructed using ADIwg mdTranslator tools available at https://github.com/adiwg ')
                            @html.meta('name'=>'description', 'content'=>'mdTranslator software is an open-source project of the Alaska Data Integration working group (ADIwg).  Alaska Data Integration working group is not responsible for the content of this metadata record')
                            @html.meta('name'=>'keywords', 'content'=>'metadata, ADIwg, mdTranslator')
                            @html.comment!('metadata record generated ' + Time.now.to_s)

                            # add inline css
                            # read css from file
                            path = File.join(File.dirname(__FILE__), 'html_inlineCss.css')
                            file = File.open(path, 'r')
                            css = file.read
                            file.close

                            @html.style do
                                @html.text!(css)
                            end

                            # append user supplied css
                            if @paramsObj[:cssLink]
                                @html.link('rel'=>'stylesheet', 'href'=> @paramsObj[:cssLink])
                            end
                            if @paramsObj[:css]
                                @html.style(@paramsObj[:css])
                            end

                            # add inline javascript
                            # read javascript from file
                            path = File.join(File.dirname(__FILE__), 'html_headScript.js')
                            file = File.open(path, 'r')
                            js = file.read
                            file.close

                            @html.script('type'=>'text/javascript') do
                                @html << js
                            end

                        end
                    end

                end

            end
        end
    end
end
