# ISO <<Class>> FC_FeatureType
# writer output in XML

# History:
# 	Stan Smith 2014-12-02 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-02-18 added aliases for entities
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)

require 'class_featureConstraint'
require 'class_featureAttribute'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class FC_FeatureType

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hEntity)

                        # classes used
                        fConClass = $IsoNS::FC_Constraint.new(@xml, @responseObj)
                        fAttClass = $IsoNS::FC_FeatureAttribute.new(@xml, @responseObj)

                        # create and identity for the entity
                        @responseObj[:missingIdCount] = @responseObj[:missingIdCount].succ
                        entityID = 'entity' + @responseObj[:missingIdCount]
                        @xml.tag!('gfc:FC_FeatureType', {'id' => entityID}) do

                            # feature type - type name - required
                            # use entity common name
                            s = hEntity[:entityName]
                            if !s.nil?
                                @xml.tag!('gfc:typeName') do
                                    @xml.tag!('gco:LocalName', s)
                                end
                            else
                                @xml.tag!('gfc:typeName', {'gco:nilReason' => 'missing'})
                            end

                            # feature type - definition
                            s = hEntity[:entityDefinition]
                            if !s.nil?
                                @xml.tag!('gfc:definition') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gfc:definition')
                            end

                            # feature type - code
                            # use entity code name
                            s = hEntity[:entityCode]
                            if !s.nil?
                                @xml.tag!('gfc:code') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gfc:code')
                            end

                            # feature type - isAbstract - required
                            # defaulted to false, value not available in internal object
                            @xml.tag!('gfc:isAbstract') do
                                @xml.tag!('gco:Boolean', 'false')
                            end

                            # feature type - aliases
                            aAliases = hEntity[:entityAlias]
                            aAliases.each do |myAlias|
                                @xml.tag!('gfc:aliases') do
                                    @xml.tag!('gco:LocalName',myAlias)
                                end
                            end

                            # feature type - feature catalogue - required
                            # 'role that links this feature type to the feature catalogue that contains it'
                            # confusing, allow definition of another feature catalogue here
                            # just set to nilReason = 'inapplicable' (recommended by NOAA)
                            @xml.tag!('gfc:featureCatalogue', {'gco:nilReason' => 'inapplicable'})

                            # feature type - constrained by
                            # use to define primary key, foreign keys, and indexes
                            # pass primary key
                            aPKs = hEntity[:primaryKey]
                            if !aPKs.empty?
                                @xml.tag!('gfc:constrainedBy') do
                                    fConClass.writeXML('pk', aPKs)
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gfc:constrainedBy')
                            end

                            # pass indexes
                            aIndexes = hEntity[:indexes]
                            if !aIndexes.empty?
                                aIndexes.each do |hIndex|
                                    @xml.tag!('gfc:constrainedBy') do
                                        fConClass.writeXML('index', hIndex)
                                    end
                                end
                            end

                            # pass foreign keys
                            aFKs = hEntity[:foreignKeys]
                            if !aFKs.empty?
                                aFKs.each do |hFK|
                                    @xml.tag!('gfc:constrainedBy') do
                                        fConClass.writeXML('fk', hFK)
                                    end
                                end
                            end

                            # feature type - character of characteristics
                            # used to define entity attributes
                            aAttributes = hEntity[:attributes]
                            if !aAttributes.empty?
                                aAttributes.each do |hAttribute|
                                    @xml.tag!('gfc:carrierOfCharacteristics') do
                                        fAttClass.writeXML(hAttribute)
                                    end
                                end
                            elsif @responseObj[:writerShowTags]
                                @xml.tag!('gfc:carrierOfCharacteristics')
                            end

                        end

                    end

                end

            end
        end
    end
end
