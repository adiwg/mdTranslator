# ISO <<Class>> image description
# 19115-1 writer output in XML

# History:
# 	Stan Smith 2019-04-08 original script

require_relative 'class_codelist'
require_relative 'class_identifier'
require_relative 'class_attributeGroup'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19115_1

            class MD_ImageDescription

               def initialize(xml, hResponseObj)
                  @xml = xml
                  @hResponseObj = hResponseObj
               end

               def writeXML(hCoverage, inContext = nil)

                  # classes used
                  codelistClass = MD_Codelist.new(@xml, @hResponseObj)
                  identifierClass = MD_Identifier.new(@xml, @hResponseObj)
                  groupClass = MD_AttributeGroup.new(@xml, @hResponseObj)

                  outContext = 'content coverage image description'

                  unless hCoverage.empty?
                     @xml.tag!('mrc:MD_ImageDescription') do

                        # image description - attribute description (required)
                        # combine coverageName and coverageDescription
                        attDesc = ''
                        unless hCoverage[:coverageName].nil?
                           attDesc += hCoverage[:coverageName] + '; '
                        end
                        unless hCoverage[:coverageDescription].nil?
                           attDesc += hCoverage[:coverageDescription]
                        end
                        unless attDesc == ''
                           @xml.tag!('mrc:attributeDescription') do
                              @xml.tag!('gco:RecordType', attDesc)
                           end
                        end
                        if attDesc == ''
                           @NameSpace.issueWarning(40, 'mrc:attributeDescription')
                        end

                        # image description - processing level code {MD_Identifier}
                        unless hCoverage[:processingLevelCode].empty?
                           @xml.tag!('mrc:processingLevelCode') do
                              identifierClass.writeXML(hCoverage[:processingLevelCode], outContext+' processing level')
                           end
                           if hCoverage[:processingLevelCode].empty? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:processingLevelCode')
                           end
                        end

                        # image description - attribute group [] {MD_AttributeGroup}
                        aGroups = hCoverage[:attributeGroups]
                        aGroups.each do |hGroup|
                           unless hGroup.empty?
                              @xml.tag!('mrc:attributeGroup') do
                                 groupClass.writeXML(hGroup, outContext)
                              end
                           end
                        end
                        if aGroups.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('mrc:attributeGroup')
                        end

                        hImage = hCoverage[:imageDescription]
                        unless hImage.empty?

                           # image description - illumination elevation angle
                           unless hImage[:illuminationElevationAngle].nil?
                              @xml.tag!('mrc:illuminationElevationAngle') do
                                 @xml.tag!('gco:Real', hImage[:illuminationElevationAngle])
                              end
                           end
                           if hImage[:illuminationElevationAngle].nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:illuminationElevationAngle')
                           end

                           # image description - illumination azimuth angle
                           unless hImage[:illuminationAzimuthAngle].nil?
                              @xml.tag!('mrc:illuminationAzimuthAngle') do
                                 @xml.tag!('gco:Real', hImage[:illuminationAzimuthAngle])
                              end
                           end
                           if hImage[:illuminationAzimuthAngle].nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:illuminationAzimuthAngle')
                           end

                           # image description - image condition {MD_ImageConditionCode}
                           unless hImage[:imagingCondition].nil?
                              @xml.tag!('mrc:imagingCondition') do
                                 codelistClass.writeXML('mrc', 'iso_imageCondition', hImage[:imagingCondition])
                              end
                           end
                           if hImage[:imagingCondition].nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:imagingCondition')
                           end

                           # image description - image quality code {MD_Identifier}
                           unless hImage[:imageQualityCode].empty?
                              @xml.tag!('mrc:imageQualityCode') do
                                 identifierClass.writeXML(hImage[:imageQualityCode], 'image quality code')
                              end
                           end
                           if hImage[:imageQualityCode].empty? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:imageQualityCode')
                           end

                           # image description - cloud cover percentage
                           unless hImage[:cloudCoverPercent].nil?
                              @xml.tag!('mrc:cloudCoverPercentage') do
                                 @xml.tag!('gco:Real', hImage[:cloudCoverPercent])
                              end
                           end
                           if hImage[:cloudCoverPercent].nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:cloudCoverPercentage')
                           end

                           # image description - compression generation quality
                           unless hImage[:compressionQuantity].nil?
                              @xml.tag!('mrc:compressionGenerationQuantity') do
                                 @xml.tag!('gco:Integer', hImage[:compressionQuantity])
                              end
                           end
                           if hImage[:compressionQuantity].nil? && @hResponseObj[:writerShowTags]
                              @xml.tag!('mrc:compressionGenerationQuantity')
                           end

                           # image description - triangulation indicator
                           @xml.tag!('mrc:triangulationIndicator') do
                              @xml.tag!('gco:Boolean', hImage[:triangulationIndicator])
                           end

                           # image description - radiometric calibration data availability
                           @xml.tag!('mrc:radiometricCalibrationDataAvailability') do
                              @xml.tag!('gco:Boolean', hImage[:radiometricCalibrationAvailable])
                           end

                           # image description - camera calibration information availability
                           @xml.tag!('mrc:cameraCalibrationInformationAvailability') do
                              @xml.tag!('gco:Boolean', hImage[:cameraCalibrationAvailable])
                           end

                           # image description - film distortion information availability
                           @xml.tag!('mrc:filmDistortionInformationAvailability') do
                              @xml.tag!('gco:Boolean', hImage[:filmDistortionAvailable])
                           end

                           # image description - lens distortion information availability
                           @xml.tag!('mrc:lensDistortionInformationAvailability') do
                              @xml.tag!('gco:Boolean', hImage[:lensDistortionAvailable])
                           end

                        end

                     end

                  end # tag MD_ImageDescription
               end # writeXML
            end # class MD_ImageDescription

         end
      end
   end
end
