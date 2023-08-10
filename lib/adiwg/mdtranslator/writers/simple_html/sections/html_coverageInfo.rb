# HTML writer
# coverage information

# History:
#  Stan Smith 2017-04-02 refactored for mdTranslator 2.0
# 	Stan Smith 2015-08-21 original script

require_relative 'html_identifier'
require_relative 'html_attributeGroup'
require_relative 'html_imageInfo'

module ADIWG
   module Mdtranslator
      module Writers
         module SimpleHtml

            class Html_CoverageInfo

               def initialize(html)
                  @html = html
               end

               def writeHtml(hCoverage)

                  # classes used
                  identifierClass = Html_Identifier.new(@html)
                  attGroupClass = Html_AttributeGroup.new(@html)
                  imageClass = Html_ImageInfo.new(@html)

                  # coverage - name
                  unless hCoverage[:coverageName].nil?
                     @html.em('Name: ')
                     @html.text!(hCoverage[:coverageName])
                     @html.br
                  end

                  # coverage - description
                  unless hCoverage[:coverageDescription].nil?
                     @html.em('Description: ')
                     @html.div(:class => 'block') do
                        @html.text!(hCoverage[:coverageDescription])
                     end
                  end

                  # coverage - process level code
                  unless hCoverage[:processingLevelCode].empty?
                     @html.div do
                        @html.div('Processing Level Code', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           identifierClass.writeHtml(hCoverage[:processingLevelCode])
                        end
                     end
                  end

                  # coverage - attribute group [] {attributeGroup}
                  hCoverage[:attributeGroups].each do |hAttGroup|
                     @html.div do
                        @html.div('Attribute Group', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           attGroupClass.writeHtml(hAttGroup)
                        end
                     end
                  end

                  # coverage - image description {imageInfo}
                  unless hCoverage[:imageDescription].empty?
                     @html.div do
                        @html.div('Image Description', {'class' => 'h5'})
                        @html.div(:class => 'block') do
                           imageClass.writeHtml(hCoverage[:imageDescription])
                        end
                     end
                  end

               end # writeHtml
            end # Html_CoverageInfo

         end
      end
   end
end
