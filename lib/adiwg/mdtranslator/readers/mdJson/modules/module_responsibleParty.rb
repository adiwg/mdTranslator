# unpack responsible party
# Reader - ADIwg JSON V1 to internal data structure

# History:
#   Stan Smith 2016-10-09 refactored for mdJson 2.0
#   Stan Smith 2015-07-14 refactored to remove global namespace constants
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-06-12 added check that contactId for responsibleParty
#   ... matches an actual contact in the contact array
#   Stan Smith 2015-01-18 added nil return if hRParty empty
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers
#   Stan Smith 2014-05-28 modified to support JSON schema 0.5.0
#   ... removed resource IDs associated with contact
# 	Stan Smith 2013-08-26 original script

require_relative 'module_timePeriod'
require_relative 'module_party'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module ResponsibleParty

                    def self.unpack(hRParty, responseObj)

                        # return nil object if input is empty
                        if hRParty.empty?
                            responseObj[:readerExecutionMessages] << 'Responsible Party object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intResParty = intMetadataClass.newRespParty

                        # responsible party - role - required
                        if hRParty.has_key?('role')
                            intResParty[:roleName] = hRParty['role']
                        end
                        if intResParty[:roleName].nil? || intResParty[:roleName] == ''
                            responseObj[:readerExecutionMessages] << 'Responsible Party role is missing'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # responsible party - time period
                        if hRParty.has_key?('timePeriod')
                            unless hRParty['timePeriod'].empty?
                                hTimePeriod = TimePeriod.unpack(hRParty['timePeriod'], responseObj)
                                unless hTimePeriod.nil?
                                    intResParty[:timePeriod] = hTimePeriod
                                end
                            end
                        end

                        # responsible party - party [] (minimum 1)
                        if hRParty.has_key?('party')
                            hRParty['party'].each do |hParty|
                                unless hParty.empty?
                                    party = Party.unpack(hParty, responseObj)
                                    unless party.nil?
                                        intResParty[:party] << party
                                    end
                                end
                            end
                        end
                        if intResParty[:party].empty?
                            responseObj[:readerExecutionMessages] << 'Responsible Party object must have at least one party'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intResParty

                    end

                end

            end
        end
    end
end
