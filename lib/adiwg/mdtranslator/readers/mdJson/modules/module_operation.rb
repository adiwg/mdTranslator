require 'adiwg/mdtranslator/internal/module_codelistFun'
require_relative 'module_citation'
require_relative 'module_identifier'
require_relative 'module_objective'
require_relative 'module_platform'
require_relative 'module_event'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module Operation
                    def self.unpack(hOperation, responseObj, inContext = nil)
                        
                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        intMetadataClass = InternalMetadata.new
                        intOperation = intMetadataClass.newOperation

                        outContext = 'operation'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        if hOperation.has_key?('operationId')
                            intOperation[:operationId] = hOperation['operationId']
                            
                        else
                            @MessagePath.issueError(42, responseObj, outContext)
                        end

                        if hOperation.has_key?('description')
                            intOperation[:description] = hOperation['description']
                        end

                        if hOperation.has_key?('citation')
                            hReturn = Citation.unpack(hOperation['citation'], responseObj, outContext)
                            unless hReturn.nil?
                                intOperation[:citation] = hReturn
                            end
                        end

                        if hOperation.has_key?('identifier')
                            hReturn = Identifier.unpack(hOperation['identifier'], responseObj, outContext)
                            unless hReturn.nil?
                                intOperation[:identifier] = hReturn
                            end
                        else
                            @MessagePath.issueError(44, responseObj, outContext)
                        end

                        if hOperation.has_key?('status') && CodelistFun.validateItem('iso_progress', hOperation['status'])
                            intOperation[:status] = hOperation['status']
                        end

                        if hOperation.has_key?('operationType') && CodelistFun.validateItem('iso_operationTypeCode', hOperation['operationType'])
                            intOperation[:operationType] = hOperation['operationType']
                        end

                        if hOperation.has_key?('objective')
                            hOperation['objective'].each do |item|
                                hReturn = Objective.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intOperation[:objectives] << hReturn
                                end
                            end
                        end

                        if hOperation.has_key?('parentOperation')
                            hReturn = Operation.unpack(hOperation['parentOperation'], responseObj, outContext)
                            unless hReturn.nil?
                                intOperation[:parentOperation] = hReturn
                            end
                        else
                            @MessagePath.issueError(44, responseObj, outContext)
                        end

                        if hOperation.has_key?('childOperation')
                            hOperation['childOperation'].each do |item|
                                hReturn = Operation.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intOperation[:childOperations] << hReturn
                                end
                            end
                        end

                        if hOperation.has_key?('plan')
                            hReturn = Plan.unpack(hOperation['plan'], responseObj, outContext)
                            unless hReturn.nil?
                                intOperation[:plan] = hReturn
                            end
                        end

                        if hOperation.has_key?('platform')
                            hOperation['platform'].each do |item|
                                hReturn = Platform.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intOperation[:platforms] << hReturn
                                end
                            end
                        end

                        if hOperation.has_key?('significantEvent')
                            hOperation['significantEvent'].each do |item|
                                hReturn = Event.unpack(item, responseObj, outContext)
                                unless hReturn.nil?
                                    intOperation[:significantEvents] << hReturn
                                end
                            end
                        end

                        intOperation

                    end
                end

            end
        end
    end
end
