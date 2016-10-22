# unpack scope
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-14 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_scopeDescription')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_timePeriod')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Scope

                    def self.unpack(hScope, responseObj)

                        # return nil object if input is empty
                        if hScope.empty?
                            responseObj[:readerExecutionMessages] << 'Scope object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intScope = intMetadataClass.newScope

                        # scope - scope code (required)
                        if hScope.has_key?('scopeCode')
                            intScope[:scopeCode] = hScope['scopeCode']
                        end
                        if intScope[:scopeCode].nil? || intScope[:scopeCode] == ''
                            responseObj[:readerExecutionMessages] << 'Scope attribute scopeCode is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # scope - scope description []
                        if hScope.has_key?('scopeDescription')
                            aScopeDes = hScope['scopeDescription']
                            aScopeDes.each do |item|
                                hScopeDes = ScopeDescription.unpack(item, responseObj)
                                unless hScopeDes.nil?
                                    intScope[:scopeDescription] << hScopeDes
                                end
                            end
                        end

                        # scope - time period []
                        if hScope.has_key?('timePeriod')
                            aTimePer = hScope['timePeriod']
                            aTimePer.each do |item|
                                hTimePer = TimePeriod.unpack(item, responseObj)
                                unless hTimePer.nil?
                                    intScope[:timePeriod] << hTimePer
                                end
                            end
                        end

                        return intScope

                    end

                end

            end
        end
    end
end