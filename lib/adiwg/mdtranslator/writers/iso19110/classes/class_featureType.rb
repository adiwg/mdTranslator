# ISO <<Class>> FC_FeatureType
# writer output in XML

# History:
#  Stan Smith 2017-11-02 add entity reference
#  Stan Smith 2017-02-03 refactored for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2015-02-18 added aliases for entities
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-02 original script

require_relative 'class_featureConstraint'
require_relative 'class_featureAttribute'
require_relative 'class_definitionReference'

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class FC_FeatureType

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
               end

               def writeXML(hEntity)

                  # classes used
                  fConClass = FC_Constraint.new(@xml, @hResponseObj)
                  fAttClass = FC_FeatureAttribute.new(@xml, @hResponseObj)
                  defRefClass = FC_DefinitionReference.new(@xml, @hResponseObj)

                  # create an identity for the entity
                  entityId = hEntity[:entityId]
                  if entityId.nil?
                     @hResponseObj[:writerMissingIdCount] = @hResponseObj[:writerMissingIdCount].succ
                     entityId = 'entity' + @hResponseObj[:writerMissingIdCount]
                  else
                     entityId.gsub!(/[^0-9a-zA-Z]/, '')
                  end

                  @xml.tag!('gfc:FC_FeatureType', {'id' => entityId}) do

                     # feature type - type name (required)
                     # used for entity common name
                     s = hEntity[:entityName]
                     unless s.nil?
                        @xml.tag!('gfc:typeName') do
                           @xml.tag!('gco:LocalName', s)
                        end
                     end
                     if s.nil?
                        @xml.tag!('gfc:typeName', {'gco:nilReason' => 'missing'})
                     end

                     # feature type - definition
                     s = hEntity[:entityDefinition]
                     unless s.nil?
                        @xml.tag!('gfc:definition') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:definition')
                     end

                     # feature type - code
                     # used for entity code name
                     s = hEntity[:entityCode]
                     unless s.nil?
                        @xml.tag!('gfc:code') do
                           @xml.tag!('gco:CharacterString', s)
                        end
                     end
                     if s.nil? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:code')
                     end

                     # feature type - isAbstract (required)
                     # always defaulted to false
                     @xml.tag!('gfc:isAbstract') do
                        @xml.tag!('gco:Boolean', 'false')
                     end

                     # feature type - aliases
                     aAliases = hEntity[:entityAlias]
                     aAliases.each do |myAlias|
                        @xml.tag!('gfc:aliases') do
                           @xml.tag!('gco:LocalName', myAlias)
                        end
                     end

                     # feature type - feature catalogue (required)
                     # 'role that links this feature type to the feature catalogue that contains it'
                     # confusing, allows definition of another feature catalogue here
                     # just set to nilReason = 'inapplicable' (as recommended by NOAA)
                     @xml.tag!('gfc:featureCatalogue', {'gco:nilReason' => 'inapplicable'})

                     # feature type - constrained by
                     # use to define primary key, foreign keys, and indexes
                     # feature type - primary key
                     aPKs = hEntity[:primaryKey]
                     unless aPKs.empty?
                        @xml.tag!('gfc:constrainedBy') do
                           fConClass.writeXML('pk', aPKs)
                        end
                     end
                     if aPKs.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:constrainedBy')
                     end

                     # feature type - indexes
                     aIndexes = hEntity[:indexes]
                     unless aIndexes.empty?
                        aIndexes.each do |hIndex|
                           @xml.tag!('gfc:constrainedBy') do
                              fConClass.writeXML('index', hIndex)
                           end
                        end
                     end

                     # feature type - foreign keys
                     aFKs = hEntity[:foreignKeys]
                     unless aFKs.empty?
                        aFKs.each do |hFK|
                           @xml.tag!('gfc:constrainedBy') do
                              fConClass.writeXML('fk', hFK)
                           end
                        end
                     end

                     # feature type - entity reference
                     aRef = hEntity[:entityReferences]
                     unless aRef.empty?
                        @xml.tag!('gfc:definitionReference') do
                           defRefClass.writeXML(aRef[0])
                        end
                     end
                     if aRef.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:definitionReference')
                     end

                     # feature type - character of characteristics
                     # used to define entity attributes
                     aAttributes = hEntity[:attributes]
                     unless aAttributes.empty?
                        aAttributes.each do |hAttribute|
                           @xml.tag!('gfc:carrierOfCharacteristics') do
                              fAttClass.writeXML(hAttribute)
                           end
                        end
                     end
                     if aAttributes.empty? && @hResponseObj[:writerShowTags]
                        @xml.tag!('gfc:carrierOfCharacteristics')
                     end

                  end # gfc:FC_FeatureType tag
               end # writeXML
            end # FC_FeatureType class

         end
      end
   end
end
