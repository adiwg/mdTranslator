# unpack constraint
# Reader - ADIwg JSON to internal data structure

# History:
#  Stan Smith 2018-06-16 refactored error and warning messaging
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

               def self.unpack(hConstraint, responseObj, inContext = nil)

                  @MessagePath = ADIWG::Mdtranslator::Readers::MdJson::MdJson

                  # return nil object if input is empty
                  if hConstraint.empty?
                     @MessagePath.issueWarning(90, responseObj, inContext)
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
                           @MessagePath.issueError(91, responseObj, inContext)
                        end
                     end
                  end
                  if intConstraint[:type].nil? || intConstraint[:type] == ''
                     @MessagePath.issueError(92, responseObj, inContext)
                  end

                  outContext = 'constraint'
                  outContext = intConstraint[:type] + ' constraint' unless intConstraint[:type].nil?
                  outContext = inContext + ' > ' + outContext unless inContext.nil?

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
                        hReturn = Scope.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intConstraint[:scope] = hReturn
                        end
                     end
                  end

                  # constraint - graphic [graphic]
                  if hConstraint.has_key?('graphic')
                     aGraphic = hConstraint['graphic']
                     aGraphic.each do |item|
                        hGraphic = Graphic.unpack(item, responseObj, outContext)
                        unless hGraphic.nil?
                           intConstraint[:graphic] << hGraphic
                        end
                     end
                  end

                  # constraint - reference [citation]
                  if hConstraint.has_key?('reference')
                     aReference = hConstraint['reference']
                     aReference.each do |item|
                        hReference = Citation.unpack(item, responseObj, outContext)
                        unless hReference.nil?
                           intConstraint[:reference] << hReference
                        end
                     end
                  end

                  # constraint - releasability
                  if hConstraint.has_key?('releasability')
                     hObject = hConstraint['releasability']
                     unless hObject.empty?
                        hReturn = Releasability.unpack(hObject, responseObj, outContext)
                        unless hReturn.nil?
                           intConstraint[:releasability] = hReturn
                        end
                     end
                  end

                  # constraint - responsible party []
                  if hConstraint.has_key?('responsibleParty')
                     aRParty = hConstraint['responsibleParty']
                     aRParty.each do |item|
                        hParty = ResponsibleParty.unpack(item, responseObj, outContext)
                        unless hParty.nil?
                           intConstraint[:responsibleParty] << hParty
                        end
                     end
                  end

                  if type == 'legal'
                     if hConstraint.has_key?('legal')
                        hObject = hConstraint['legal']
                        unless hObject.empty?
                           hReturn = LegalConstraint.unpack(hObject, responseObj, inContext)
                           unless hReturn.nil?
                              intConstraint[:legalConstraint] = hReturn
                           end
                           if hReturn.nil?
                              return nil
                           end
                        end
                        if hObject.empty?
                           @MessagePath.issueError(93, responseObj, inContext)
                        end
                     else
                        @MessagePath.issueError(93, responseObj, inContext)
                     end
                  end

                  if type == 'security'
                     if hConstraint.has_key?('security')
                        hObject = hConstraint['security']
                        unless hObject.empty?
                           hReturn = SecurityConstraint.unpack(hObject, responseObj, inContext)
                           unless hReturn.nil?
                              intConstraint[:securityConstraint] = hReturn
                           end
                           if hReturn.nil?
                              return nil
                           end
                        end
                        if hObject.empty?
                           @MessagePath.issueError(94, responseObj, inContext)
                        end
                     else
                        @MessagePath.issueError(94, responseObj, inContext)
                     end
                  end

                  return intConstraint

               end

            end

         end
      end
   end
end
