require_relative 'module_dateTime'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
  
                module RequestedDate
                    def self.unpack(hRequestedDate, responseObj, inContext = nil)

                        @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                        outContext = 'RequestedDate'
                        outContext = inContext + ' > ' + outContext unless inContext.nil?

                        # return nil object if input is empty
                        if hRequestedDate.empty?
                            @MessagePath.issueWarning(41, responseObj, outContext)
                            return nil
                        end

                        intMetadataClass = InternalMetadata.new
                        intRequestedDate = intMetadataClass.newRequestedDate

                        if hRequestedDate.has_key?('requestedDateOfCollection')
                            hReturn = DateTime.unpack(hRequestedDate['requestedDateOfCollection'], responseObj, outContext)
                            unless hReturn.nil?
                                intRequestedDate[:requestedDateOfCollection] = hReturn
                            else
                                @MessagePath.issueError(161, responseObj, inContext)
                            end
                        end

                        if hRequestedDate.has_key?('latestAcceptableDate')
                            hReturn = DateTime.unpack(hRequestedDate['latestAcceptableDate'], responseObj, outContext)
                            unless hReturn.nil?
                                intRequestedDate[:latestAcceptableDate] = hReturn
                            else
                                @MessagePath.issueError(161, responseObj, inContext)
                            end
                        end

                        intRequestedDate

                    end
                end

            end
        end
    end
end