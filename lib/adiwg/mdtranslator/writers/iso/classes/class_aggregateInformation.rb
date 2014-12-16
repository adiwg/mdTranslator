# ISO <<Class>> MD_AggregateInformation
# writer output in XML

# History:
# 	Stan Smith 2014-05-29 original script
#   Stan Smith 2014-07-08 modify require statements to function in RubyGem structure
#   Stan Smith 2014-11-06 take initiativeType from internal initiativeType
#   ... rather than resourceType for 0.9.0
#   Stan Smith 2014-12-15 refactored to handle namespacing readers and writers

require 'code_associationType'
require 'code_initiativeType'
require 'class_citation'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class MD_AggregateInformation

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hAssocRes)

                        # aggregate information is being supported in the 19115-1 style,
                        # ... aggregateDataSetIdentifier is being dropped and
                        # ... resource identifiers are being carried inside the
                        # ... citation > identifier section

                        # classes used
                        assocCode = $WriterNS::DS_AssociationTypeCode.new(@xml)
                        initCode = $WriterNS::DS_InitiativeTypeCode.new(@xml)
                        citationClass = $WriterNS::CI_Citation.new(@xml)

                        @xml.tag!('gmd:MD_AggregateInformation') do

                            # aggregate information - aggregate data set name - citation
                            hAssocCit = hAssocRes[:resourceCitation]
                            if !hAssocCit.empty?
                                @xml.tag!('gmd:aggregateDataSetName') do
                                    citationClass.writeXML(hAssocCit)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:aggregateDataSetName')
                            end

                            # aggregate information - aggregate data set identifier (use citation > identifier)

                            # aggregate information - association type
                            s = hAssocRes[:associationType]
                            if !s.nil?
                                @xml.tag!('gmd:associationType') do
                                    assocCode.writeXML(s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:associationType')
                            end

                            # aggregate information - initiative type
                            s = hAssocRes[:initiativeType]
                            if !s.nil?
                                @xml.tag!('gmd:initiativeType') do
                                    initCode.writeXML(s)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:initiativeType')
                            end

                        end

                    end

                end

            end
        end
    end
end
