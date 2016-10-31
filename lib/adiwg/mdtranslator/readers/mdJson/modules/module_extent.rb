# unpack a extent
# Reader - mdJson to internal data structure

# History:
#   Stan Smith 2016-10-30 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_geographicExtent')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_temporalExtent')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_verticalExtent')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Extent

                    def self.unpack(hExtent, responseObj)

                        # return nil object if input is empty
                        if hExtent.empty?
                            responseObj[:readerExecutionMessages] << 'Extent object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intExtent = intMetadataClass.newExtent

                        # extent - description
                        if hExtent.has_key?('description')
                            if  hExtent['description'] != ''
                                intExtent[:description] =  hExtent['description']
                            end
                        end

                        # extent - geographicExtent
                        if hExtent.has_key?('geographicExtent')
                            hExtent['geographicExtent'].each do |item|
                                unless item.empty?
                                    hReturn = GeographicExtent.unpack(item, responseObj)
                                    unless hReturn.nil?
                                        intExtent[:geographicExtents] << hReturn
                                    end
                                end
                            end
                        end

                        # extent - temporalExtent
                        if hExtent.has_key?('temporalExtent')
                            hExtent['temporalExtent'].each do |item|
                                unless item.empty?
                                    hReturn = TemporalExtent.unpack(item, responseObj)
                                    unless hReturn.nil?
                                        intExtent[:temporalExtents] << hReturn
                                    end
                                end
                            end
                        end

                        # extent - verticalExtent
                        if hExtent.has_key?('verticalExtent')
                            hExtent['verticalExtent'].each do |item|
                                unless item.empty?
                                    hReturn = VerticalExtent.unpack(item, responseObj)
                                    unless hReturn.nil?
                                        intExtent[:verticalExtents] << hReturn
                                    end
                                end
                            end
                        end

                        return intExtent

                    end

                end

            end
        end
    end
end
