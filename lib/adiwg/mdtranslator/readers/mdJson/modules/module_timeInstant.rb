# unpack time instant
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-24 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_dateTime')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module TimeInstant

                    def self.unpack(hInstant, responseObj)

                        # return nil object if input is empty
                        if hInstant.empty?
                            responseObj[:readerExecutionMessages] << 'Time Instant object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intInstant = intMetadataClass.newTimeInstant

                        # time period - id
                        if hInstant.has_key?('id')
                            if hInstant['id'] != ''
                                intInstant[:timeId] = hInstant['id']
                            end
                        end

                        # time period - description
                        if hInstant.has_key?('description')
                            if hInstant['description'] != ''
                                intInstant[:description] = hInstant['description']
                            end
                        end

                        # time period - identifier
                        if hInstant.has_key?('identifier')
                            if hInstant['identifier'] != ''
                                intInstant[:identifier] = hInstant['identifier']
                            end
                        end

                        # time period - instant names []
                        if hInstant.has_key?('instantName')
                            hInstant['instantName'].each do |item|
                                if item != ''
                                    intInstant[:instantNames] << item
                                end
                            end
                        end

                        # time period - datetime
                        if hInstant.has_key?('dateTime')
                            if hInstant['dateTime'] != ''
                                hDate = DateTime.unpack(hInstant['dateTime'], responseObj)
                                unless hDate.nil?
                                    intInstant[:timeInstant] = hDate
                                end
                            end
                        end
                        if intInstant[:timeInstant].empty?
                            responseObj[:readerExecutionMessages] << 'Time Instant is missing dateTime'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intInstant

                    end

                end

            end
        end
    end
end
