# unpack GeoJSON properties
# Reader - ADIwg JSON V1 to internal data structure

# History:
# 	Stan Smith 2014-04-29 original script
#   Stan Smith 2014-07-07 resolve require statements using Mdtranslator.reader_module
#   Stan Smith 2014-08-18 changed assignedId to identifier schema 0.6.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require $ReaderNS.readerModule('module_temporalElement')
require $ReaderNS.readerModule('module_verticalElement')
require $ReaderNS.readerModule('module_resourceIdentifier')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module GeoProperties

                    def self.unpack(hGeoProps, intElement, responseObj)

                        # set element extent - (default true)
                        intElement[:elementIncludeData] = true
                        if hGeoProps.has_key?('includesData')
                            if !hGeoProps['includesData']
                                intElement[:elementIncludeData] = false
                            end
                        end

                        # set element feature name
                        if hGeoProps.has_key?('featureName')
                            s = hGeoProps['featureName']
                            if s != ''
                                intElement[:elementName] = s
                            end
                        end

                        # set element description
                        if hGeoProps.has_key?('description')
                            s = hGeoProps['description']
                            if s != ''
                                intElement[:elementDescription] = s
                            end
                        end

                        # set temporal information
                        if hGeoProps.has_key?('temporalElement')
                            hTempEle = hGeoProps['temporalElement']
                            unless hTempEle.empty?
                                intElement[:temporalElements] = $ReaderNS::TemporalElement.unpack(hTempEle, responseObj)
                            end
                        end

                        # set vertical information
                        if hGeoProps.has_key?('verticalElement')
                            aVertEle = hGeoProps['verticalElement']
                            unless aVertEle.empty?
                                aVertEle.each do |hVertEle|
                                    intElement[:verticalElements] << $ReaderNS::VerticalElement.unpack(hVertEle, responseObj)
                                end
                            end
                        end

                        # set other assigned IDs
                        if hGeoProps.has_key?('identifier')
                            aResIds = hGeoProps['identifier']
                            unless aResIds.empty?
                                aResIds.each do |hIdentifier|
                                    intElement[:elementIdentifiers] << $ReaderNS::ResourceIdentifier.unpack(hIdentifier, responseObj)
                                end
                            end
                        end

                        # set feature scope
                        if hGeoProps.has_key?('featureScope')
                            s = hGeoProps['featureScope']
                            if s != ''
                                intElement[:elementScope] = s
                            end
                        end

                        # set feature acquisition methodology
                        if hGeoProps.has_key?('featureAcquisitionMethod')
                            s = hGeoProps['featureAcquisitionMethod']
                            if s != ''
                                intElement[:elementAcquisition] = s
                            end
                        end

                        return intElement

                    end

                end

            end
        end
    end
end
