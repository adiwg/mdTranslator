# ISO <<Class>> FC_FeatureAttribute
# writer output in XML
# create create attributes for entities

# History:
# 	Stan Smith 2014-12-02 original script
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers

require 'class_multiplicity'
require 'class_listedValue'
require 'class_unitsOfMeasure'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class FC_FeatureAttribute

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hAttribute)

                        # classes used
                        multiClass = $WriterNS::Multiplicity.new(@xml)
                        listClass = $WriterNS::FC_ListedValue.new(@xml)
                        uomClass = $WriterNS::UnitsOfMeasure.new(@xml)

                        @xml.tag!('gfc:FC_FeatureAttribute') do

                            # feature attribute - member name - required
                            # used to define attribute common name
                            s = hAttribute[:attributeName]
                            if !s.nil?
                                @xml.tag!('gfc:memberName') do
                                    @xml.tag!('gco:LocalName', s)
                                end
                            else
                                @xml.tag!('gfc:memberName', {'gco:nilReason' => 'missing'})
                            end

                            # feature attribute - definition
                            s = hAttribute[:attributeDefinition]
                            if !s.nil?
                                @xml.tag!('gfc:definition') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gfc:definition')
                            end

                            # feature attribute - cardinality - required
                            b = hAttribute[:allowNull]
                            if !b.nil?
                                @xml.tag!('gfc:cardinality') do
                                    multiClass.writeXML(b)
                                end
                            else
                                @xml.tag!('gfc:cardinality', {'gco:nilReason' => 'missing'})
                            end

                            # feature attribute - code
                            s = hAttribute[:attributeCode]
                            if !s.nil?
                                @xml.tag!('gfc:code') do
                                    @xml.tag!('gco:CharacterString', s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gfc:code')
                            end

                            # feature attribute - value measurement unit (units of measure)
                            s = hAttribute[:unitOfMeasure]
                            if !s.nil?
                                @xml.tag!('gfc:valueMeasurementUnit') do
                                    uomClass.writeUnits(s)
                                end
                            end

                            # feature attribute - value type (datatype)
                            s = hAttribute[:dataType]
                            if !s.nil?
                                @xml.tag!('gfc:valueType') do
                                    @xml.tag!('gco:TypeName') do
                                        @xml.tag!('gco:aName') do
                                            @xml.tag!('gco:CharacterString', s)
                                        end
                                    end
                                end
                            elsif $showAllTags
                                @xml.tag!('gfc:valueType')
                            end

                            # feature attribute - listed value (domain)
                            domainID = hAttribute[:domainId]
                            if !domainID.nil?
                                # find domain in domain array
                                hDomain = listClass.getDomain(domainID)
                                unless hDomain.empty?

                                    # only the domain items are represented in iso
                                    aItems = hDomain[:domainItems]
                                    aItems.each do |hItem|
                                        @xml.tag!('gfc:listedValue') do
                                            listClass.writeXML(hItem)
                                        end
                                    end

                                end
                            elsif $showAllTags
                                @xml.tag!('gfc:listedValue')
                            end


                        end
                    end

                end

            end
        end
    end
end
