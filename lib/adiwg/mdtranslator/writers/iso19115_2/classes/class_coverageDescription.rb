# ISO <<abstract class>> CoverageDescription
# 19115-2 writer output in XML

# History:
#  Stan Smith 2018-04-09 add error and warning messaging
#  Stan Smith 2016-11-23 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script.

require_relative '../iso19115_2_writer'
require_relative 'class_codelist'
require_relative 'class_attribute'
require_relative 'class_image'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_2

            class CoverageDescription

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
                  @NameSpace = ADIWG::Mdtranslator::Writers::Iso19115_2
               end
               
               def writeXML(hCoverage)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  attributeClass = Attribute.new(@xml, @hResponseObj)
                  imageClass = MI_ImageDescription.new(@xml, @hResponseObj)

                  # determine type of MD_CoverageDescription to write
                  if hCoverage[:imageDescription].empty?
                     contentTag = 'gmi:MI_CoverageDescription'
                  else
                     contentTag = 'gmi:MI_ImageDescription'
                  end

                  @xml.tag!(contentTag) do

                     # coverage description - attribute description (required)
                     # combine coverageName and coverageDescription
                     attDesc = ''
                     unless hCoverage[:coverageName].nil?
                        attDesc += hCoverage[:coverageName] + '; '
                     end
                     unless hCoverage[:coverageDescription].nil?
                        attDesc += hCoverage[:coverageDescription]
                     end
                     unless attDesc == ''
                        @xml.tag!('gmd:attributeDescription') do
                           @xml.tag!('gco:RecordType', attDesc)
                        end
                     end
                     if attDesc == ''
                        @NameSpace.issueWarning(40, 'gmd:attributeDescription')
                     end

                     # coverage description - content type (required) {MD_CoverageContentTypeCode}
                     # coverageContentTypeCode (ISO) = attributeContentType (mdJson)
                     # in ISO 19115-1 coverageContentTypeCode [] (required) in attributeGroup
                     # ... coverageContentTypeCode applies only to attributeGroup
                     # in ISO 19115-2 coverageContentTypeCode (required) in CoverageDescription
                     # ... contentInfo must be either coverageDescription or imageDescription
                     # ... coverageContentTypeCode applies to both imageDescription and attribute (rangeDimension)
                     # mdJson does not require either attributeGroup or imageDescription
                     # so, coverageContentTypeCode will be missing when content info is imageDescription
                     # how to handle in ISO 19115-2 ...
                     # when content info is imageDescription set contentCoverageType to 'image'
                     # when content info is attributeGroup contentCoverageType will be available
                     # when content info is not provided set contentType to 'nilReason=missing'
                     contentType = nil
                     contentType = 'image' if contentTag == 'gmi:MI_ImageDescription'
                     if contentTag == 'gmi:MI_CoverageDescription'
                        aGroups = hCoverage[:attributeGroups]
                        unless aGroups.empty?
                           aAttContents = aGroups[0][:attributeContentTypes]
                           unless aAttContents.empty?
                              contentType = aAttContents[0]
                           end
                        end
                     end
                     unless contentType.nil?
                        @xml.tag!('gmd:contentType') do
                           codelistClass.writeXML('gmd', 'iso_coverageContentType', contentType)
                        end
                     end
                     if contentType.nil?
                        @NameSpace.issueWarning(41, 'gmd:contentType')
                     end

                     # coverage description - dimension []
                     haveAttribute = false
                     if contentTag == 'gmi:MI_CoverageDescription'
                        aGroups.each do |hGroup|
                           aAttributes = hGroup[:attributes]
                           aAttributes.each do |hAttribute|
                              @xml.tag!('gmd:dimension') do
                                 attributeClass.writeXML(hAttribute)
                                 haveAttribute = true
                              end
                           end
                        end
                        if !haveAttribute && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:dimension')
                        end
                     end

                     # coverage description - image information
                     if contentTag == 'gmi:MI_ImageDescription'
                        hImage = hCoverage[:imageDescription]
                        unless hImage.empty?
                           imageClass.writeXML(hCoverage)
                        end
                     end

                  end # MI_CoverageDescription/MI_ImageDescription tag
               end # writeXML
            end # ContentInformation class

         end
      end
   end
end
