# unpack releasability
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-15 original script

require_relative 'module_responsibleParty'

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Releasability

                    def self.unpack(hRelease, responseObj)

                        # return nil object if input is empty
                        if hRelease.empty?
                            responseObj[:readerExecutionMessages] << 'Releasability object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intRelease = intMetadataClass.newRelease

                        # releasability - addressee [responsibleParty]
                        if hRelease.has_key?('addressee')
                            aRParty = hRelease['addressee']
                            aRParty.each do |item|
                                hParty = ResponsibleParty.unpack(item, responseObj)
                                unless hParty.nil?
                                    intRelease[:addressee] << hParty
                                end
                            end
                        end

                        # releasability - statement
                        if hRelease.has_key?('statement')
                            if hRelease['statement'] != ''
                                intRelease[:statement] = hRelease['statement']
                            end
                        end

                        # releasability - dissemination constraint []
                        if hRelease.has_key?('disseminationConstraint')
                            hRelease['disseminationConstraint'].each do |item|
                                if item != ''
                                    intRelease[:disseminationConstraint] << item
                                end
                            end
                        end

                        if intRelease[:addressee].empty? && intRelease[:statement].nil?
                            responseObj[:readerExecutionMessages] << 'Releasability must have at least one addressee or statement'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        return intRelease

                    end

                end

            end
        end
    end
end