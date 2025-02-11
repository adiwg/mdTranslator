require 'jbuilder'
require_relative 'mdJson_dateTime'

module ADIWG
    module Mdtranslator
        module Writers
            module MdJson

                module RequestedDate

                    @Namespace = ADIWG::Mdtranslator::Writers::MdJson

                    def self.build(hRequestedDate)

                        Jbuilder.new do |json|
                            json.requestedDateOfCollection DateTime.build(hRequestedDate[:requestedDateOfCollection])
                            json.latestAcceptableDate DateTime.build(hRequestedDate[:latestAcceptableDate])
                        end

                    end
                end # Requested Date

            end
        end
    end
end
