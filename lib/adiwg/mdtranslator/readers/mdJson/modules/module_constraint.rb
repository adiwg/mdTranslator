# unpack constraint
# Reader - ADIwg JSON to internal data structure

# History:
# 	Stan Smith 2016-10-15 original script

require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_scope')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_graphic')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_citation')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_releasability')
require ADIWG::Mdtranslator::Readers::MdJson.readerModule('module_responsibleParty')

module ADIWG
    module Mdtranslator
        module Readers
            module MdJson

                module Constraint

                    def self.unpack(hConstraint, responseObj)


                        # return nil object if input is empty
                        if hConstraint.empty?
                            responseObj[:readerExecutionMessages] << 'Constraint object is empty'
                            responseObj[:readerExecutionPass] = false
                            return nil
                        end

                        # instance classes needed in script
                        intMetadataClass = InternalMetadata.new
                        intConstraint = intMetadataClass.newConstraint

                        # constraint - use limitation []
                        if hConstraint.has_key?('useLimitation')
                            hConstraint['useLimitation'].each do |item|
                                if item != ''
                                    intConstraint[:useLimitation] << item
                                end
                            end
                        end

                        # constraint - scope
                        if hConstraint.has_key?('scope')
                            hObject = hConstraint['scope']
                            unless hObject.empty?
                                hReturn = Scope.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intConstraint[:scope] = hReturn
                                end
                            end
                        end

                        # constraint - graphic [graphic]
                        if hConstraint.has_key?('graphic')
                            aGraphic = hConstraint['graphic']
                            aGraphic.each do |item|
                                hGraphic = Graphic.unpack(item, responseObj)
                                unless hGraphic.nil?
                                    intConstraint[:graphic] << hGraphic
                                end
                            end
                        end

                        # constraint - reference [citation]
                        if hConstraint.has_key?('reference')
                            aReference = hConstraint['reference']
                            aReference.each do |item|
                                hReference = Citation.unpack(item, responseObj)
                                unless hReference.nil?
                                    intConstraint[:reference] << hReference
                                end
                            end
                        end

                        # constraint - releasability
                        if hConstraint.has_key?('releasability')
                            hObject = hConstraint['releasability']
                            unless hObject.empty?
                                hReturn = Releasability.unpack(hObject, responseObj)
                                unless hReturn.nil?
                                    intConstraint[:releasability] = hReturn
                                end
                            end
                        end

                        # constraint - responsible party []
                        if hConstraint.has_key?('responsibleParty')
                            aRParty = hConstraint['responsibleParty']
                            aRParty.each do |item|
                                hParty = ResponsibleParty.unpack(item, responseObj)
                                unless hParty.nil?
                                    intConstraint[:responsibleParty] << hParty
                                end
                            end
                        end

                        return intConstraint

                    end

                end

            end
        end
    end
end
