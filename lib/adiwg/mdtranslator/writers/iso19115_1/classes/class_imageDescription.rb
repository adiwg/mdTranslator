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
                  identifierClass = RS_Identifier.new(@xml, @hResponseObj)
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
                           @NameSpace.issueWarning(40, 'gmd:attributeDescription')
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

                     end

                     hImage = hCoverage[:imageDescription]
                     unless hImage.empty?

                        # image description - illumination elevation angle
                        s = hImage[:illuminationElevationAngle]
                        unless s.nil?
                           @xml.tag!('gmd:illuminationElevationAngle') do
                              @xml.tag!('gco:Real', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:illuminationElevationAngle')
                        end

                        # image description - illumination azimuth angle
                        s = hImage[:illuminationAzimuthAngle]
                        unless s.nil?
                           @xml.tag!('gmd:illuminationAzimuthAngle') do
                              @xml.tag!('gco:Real', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:illuminationAzimuthAngle')
                        end

                        # image description - image condition {MD_ImageConditionCode}
                        s = hImage[:imagingCondition]
                        unless s.nil?
                           @xml.tag!('gmd:imagingCondition') do
                              codelistClass.writeXML('gmd', 'iso_imageCondition', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:imagingCondition')
                        end

                        # image description - image quality code {MD_Identifier}
                        resId = hImage[:imageQualityCode]
                        unless resId.empty?
                           @xml.tag!('gmd:imageQualityCode') do
                              identifierClass.writeXML(resId, 'image quality code')
                           end
                        end
                        if resId.empty? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:imageQualityCode')
                        end

                        # image description - cloud cover percentage
                        s = hImage[:cloudCoverPercent]
                        unless s.nil?
                           @xml.tag!('gmd:cloudCoverPercentage') do
                              @xml.tag!('gco:Real', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:cloudCoverPercentage')
                        end

                        # image description - compression generation quality
                        s = hImage[:compressionQuantity]
                        unless s.nil?
                           @xml.tag!('gmd:compressionGenerationQuantity') do
                              @xml.tag!('gco:Integer', s)
                           end
                        end
                        if s.nil? && @hResponseObj[:writerShowTags]
                           @xml.tag!('gmd:compressionGenerationQuantity')
                        end

                        # image description - triangulation indicator
                        s = hImage[:triangulationIndicator]
                        @xml.tag!('gmd:triangulationIndicator') do
                           @xml.tag!('gco:Boolean', s)
                        end

                        # image description - radiometric calibration data availability
                        s = hImage[:radiometricCalibrationAvailable]
                        @xml.tag!('gmd:radiometricCalibrationDataAvailability') do
                           @xml.tag!('gco:Boolean', s)
                        end

                        # image description - camera calibration information availability
                        s = hImage[:cameraCalibrationAvailable]
                        @xml.tag!('gmd:cameraCalibrationInformationAvailability') do
                           @xml.tag!('gco:Boolean', s)
                        end

                        # image description - film distortion information availability
                        s = hImage[:filmDistortionAvailable]
                        @xml.tag!('gmd:filmDistortionInformationAvailability') do
                           @xml.tag!('gco:Boolean', s)
                        end

                        # image description - lens distortion information availability
                        s = hImage[:lensDistortionAvailable]
                        @xml.tag!('gmd:lensDistortionInformationAvailability') do
                           @xml.tag!('gco:Boolean', s)
                        end

                     end

                  end # tag MD_ImageDescription
               end # writeXML
            end # class MD_ImageDescription

         end
      end
   end
end
