require 'adiwg/mdtranslator/internal/module_codelistFun'
require_relative 'module_identifier'
require_relative 'module_extent'
require_relative 'module_event'
require_relative 'module_pass'
require_relative 'module_instrument'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Objective
                    def self.unpack(hObjective, responseObj, inContext = nil)

                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intObjective = intMetadataClass.newObjective

                        outContext = 'objective'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hObjective.has_key?('objectiveId')
                            intObjective[:objectiveId] = hObjective['objectiveId']
                        else
                            @MessagePath.issueError(200, responseObj, outContext)
                        end

                        if hObjective.has_key?('identifier')
                            aItems = hObjective['identifier']
                            aItems.each do |item|
                                hReturn = Identifier.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intObjective[:identifiers] << hReturn
                                end
                            end
                        else
                            @MessagePath.issueError(201, responseObj, outContext)
                        end

                        if hObjective.has_key?('priority')
                            intObjective[:priority] = hObjective['priority']
                        end

                        if hObjective.has_key?('objectiveType')
                            aItems = hObjective['objectiveType']
                            aItems.each do |item|
                                if CodelistFun.validateItem('iso_objectiveTypeCode', item)
                                    intObjective[:objectiveTypes] << item
                                end
                            end
                        end

                        if hObjective.has_key?('function')
                            hObjective['function'].each do |item|
                                intObjective[:functions] << item
                            end
                        end

                        if hObjective.has_key?('extent')
                            hObjective['extent'].each do |item|
                                hReturn = Extent.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intObjective[:extents] << hReturn
                                end
                            end
                        end

                        if hObjective.has_key?('objectiveOccurrence')
                            hObjective['objectiveOccurrence'].each do |item|
                                hReturn = Event.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intObjective[:occurrences] << hReturn
                                end
                            end
                        end

                        if hObjective.has_key?('pass')
                            hObjective['pass'].each do |item|
                                hReturn = Pass.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intObjective[:passes] << hReturn
                                end
                            end
                        end

                        if hObjective.has_key?('sensingInstrument')
                            hObjective['sensingInstrument'].each do |item|
                                hReturn = Instrument.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intObjective[:sensingInstruments] << hReturn
                                end
                            end
                        end

                        intObjective
                    end
                end

            end
        end
    end
end