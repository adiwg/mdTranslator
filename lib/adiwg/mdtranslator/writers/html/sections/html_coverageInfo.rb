# HTML writer
# coverage information

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_identifier'
require_relative 'html_coverageItem'
require_relative 'html_imageInfo'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlCoverageInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hCover)

                        # classes used
                        htmlResId = MdHtmlResourceId.new(@html)
                        htmlItem = MdHtmlCoverageItem.new(@html)
                        htmlImage = MdHtmlImageInfo.new(@html)

                        # coverage information - type
                        s = hCover[:coverageType]
                        if !s.nil?
                            @html.em('Coverage type: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage information - name
                        s = hCover[:coverageName]
                        if !s.nil?
                            @html.em('Coverage name: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage information - description
                        s = hCover[:coverageDescription]
                        if !s.nil?
                            @html.em('Coverage description: ')
                            @html.text!(s)
                            @html.br
                        end

                        # coverage information - processing level
                        hIdentifier = hCover[:processingLevel]
                        if !hIdentifier.empty?
                            @html.em('Processing level: ')
                            @html.section(:class=>'block') do
                                htmlResId.writeHtml(hIdentifier)
                            end
                        end

                        # coverage information - items
                        aCoverItems = hCover[:coverageItems]
                        aCoverItems.each do |hCovItem|
                            @html.details do
                                @html.summary(hCovItem[:itemName], {'class'=>'h5'})
                                @html.section(:class=>'block') do
                                    htmlItem.writeHtml(hCovItem)
                                end
                            end
                        end

                        # coverage information - image info
                        hImage = hCover[:imageInfo]
                        if !hImage.empty?
                            @html.em('Image information: ')
                            @html.section(:class=>'block') do
                                htmlImage.writeHtml(hImage)
                            end
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
