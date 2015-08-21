# unpack coverage information
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2015-08-19 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_resourceIdentifier')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_coverageItem')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_imageInfo')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module CoverageInfo

                    def self.unpack(hCoverage, responseObj)

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        hCover = intMetadataClass.newCoverageInfo

                        # coverage information - coverage type
                        if hCoverage.has_key?('coverageType')
                            s = hCoverage['coverageType']
                            if s != ''
                                hCover[:coverageType] = s
                            end
                        end

                        # coverage information - coverage name
                        if hCoverage.has_key?('coverageName')
                            s = hCoverage['coverageName']
                            if s != ''
                                hCover[:coverageName] = s
                            end
                        end

                        # coverage information - coverage description
                        if hCoverage.has_key?('coverageDescription')
                            s = hCoverage['coverageDescription']
                            if s != ''
                                hCover[:coverageDescription] = s
                            end
                        end

                        # coverage information - processing level - identifier
                        if hCoverage.has_key?('processingLevel')
                            hProcess = hCoverage['processingLevel']
                            if !hProcess.empty?
                                hCover[:processingLevel] = ResourceIdentifier.unpack(hProcess, responseObj)
                            end
                        end

                        # coverage information - coverage items
                        if hCoverage.has_key?('coverageItem')
                            aCoverItems = hCoverage['coverageItem']
                            aCoverItems.each do |hCoverItem|
                                if !hCoverItem.empty?
                                    hCover[:coverageItems] << CoverageItem.unpack(hCoverItem, responseObj)
                                end
                            end
                        end

                        # coverage information - image information
                        if hCoverage.has_key?('imageInfo')
                            hImageInfo = hCoverage['imageInfo']
                            if !hImageInfo.empty?
                                hCover[:imageInfo] = ImageInfo.unpack(hImageInfo, responseObj)
                            end
                        end

                        return hCover

                    end

                end

            end
        end
    end
end
