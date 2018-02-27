# unpack constraint
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-02-18 refactored error and warning messaging
# 	Stan Smith 2016-10-15 original script

require_relative 'module_scope'
require_relative 'module_graphic'
require_relative 'module_citation'
require_relative 'module_releasability'
require_relative 'module_responsibleParty'
require_relative 'module_legalConstraint'
require_relative 'module_securityConstraint'

module ADIWG
   module Mdtranslator
      module Readers
         module MdJson

            module Constraint

               def self.unpack(hConstraint, responseObj)

                  # return nil object if input is empty
                  if hConstraint.empty?
                     responseObj[:readerExecutionMessages] << 'WARNING: mdJson reader: constraint object is empty'
                     return nil
                  end

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  intConstraint = intMetadataClass.newConstraint

                  # constraint - type (required)
                  type = nil
                  if hConstraint.has_key?('type')
                     unless hConstraint['type'] == ''
                        type = hConstraint['type']
                        if %w{ use legal security }.one? {|word| word == type}
                           intConstraint[:type] = hConstraint['type']
                        else
                           responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: constraint type must be use, legal, or security'
                           responseObj[:readerExecutionPass] = false
                           return nil
                        end
                     end
                  end
                  if intConstraint[:type].nil? || intConstraint[:type] == ''
                     responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: constraint type is missing'
                     responseObj[:readerExecutionPass] = false
                     return nil
                  end

                  # constraint - use limitation [] (required if type='use')
                  if hConstraint.has_key?('useLimitation')
                     hConstraint['useLimitation'].each do |item|
                        unless item == ''
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

                  if type == 'legal'
                     if hConstraint.has_key?('legal')
                        hObject = hConstraint['legal']
                        unless hObject.empty?
                           hReturn = LegalConstraint.unpack(hObject, responseObj)
                           unless hReturn.nil?
                              intConstraint[:legalConstraint] = hReturn
                           end
                           if hReturn.nil?
                              return nil
                           end
                        end
                        if hObject.empty?
                           responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: legal constraint object is missing'
                           responseObj[:readerExecutionPass] = false
                           return nil
                        end
                     else
                        responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: legal constraint object is missing'
                        responseObj[:readerExecutionPass] = false
                        return nil
                     end
                  end

                  if type == 'security'
                     if hConstraint.has_key?('security')
                        hObject = hConstraint['security']
                        unless hObject.empty?
                           hReturn = SecurityConstraint.unpack(hObject, responseObj)
                           unless hReturn.nil?
                              intConstraint[:securityConstraint] = hReturn
                           end
                           if hReturn.nil?
                              return nil
                           end
                        end
                        if hObject.empty?
                           responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: security constraint object is missing'
                           responseObj[:readerExecutionPass] = false
                           return nil
                        end
                     else
                        responseObj[:readerExecutionMessages] << 'ERROR: mdJson reader: security constraint object is missing'
                        responseObj[:readerExecutionPass] = false
                        return nil
                     end
                  end

                  return intConstraint

               end

            end

         end
      end
   end
end
