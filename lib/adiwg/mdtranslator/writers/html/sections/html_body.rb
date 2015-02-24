

require 'html_metadataInfo'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlBody
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(intObj)
                        @html.body do

                            # classes used
                            htmlMetaInfo = $HtmlNS::MdHtmlMetadataInfo.new(@html)

                            # make sections of the internal data store more accessible
                            hMetadata = intObj[:metadata]
                            aDataDict = intObj[:dataDictionary]

                            # set page title with logo
                            # read logo from file
                            path = File.join(File.dirname(__FILE__), 'logo150.txt')
                            file = File.open(path, 'r')
                            logo = file.read
                            file.close

                            @html.h2('id'=>'mainHeader') do
                                @html.img('width'=>'150', 'height'=>'39', 'title'=>'', 'alt'=>'', 'src'=>logo)
                                @html.span('Metadata Report')
                                @html.span('HTML','class'=>'version')
                            end

                            # report title
                            @html.h1('mdTranslator Metadata Report', 'id'=>'mdtranslator-metadata-report')

                            # metadata source
                            @html.h2('Metadata Source', 'id'=>'metadata-source')
                            @html.blockquote do
                                @html.em('Metadata schema:')
                                @html.text!(intObj[:schema][:name])
                                @html.br

                                @html.em('Schema version:')
                                @html.text!(intObj[:schema][:version])
                                @html.br
                            end
                            @html.hr

                            # metadata information section
                            @html.h2('Metadata Information', 'id'=>'metadata-information')
                            @html.blockquote do
                                htmlMetaInfo.writeHtml(hMetadata[:metadataInfo])
                            end
                            @html.br
                            @html.hr

                            # resource information section
                            @html.h2('Resource Information', 'id'=>'resource-information')
                            @html.blockquote do

                            end
                            @html.br
                            @html.hr

                        end # body
                    end # def writeHtml

                end

            end
        end
    end
end
