# ISO <<Class>> DQ_Scope
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 original script

require_relative 'class_codelist'
require_relative 'class_extent'
require_relative 'class_scopeDescription'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class DQ_Scope

                    def initialize(xml, responseObj)
                        @xml = xml
                        @hResponseObj = responseObj
                    end

                    def writeXML(hScope)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @hResponseObj)
                        extentClass =  EX_Extent.new(@xml, @hResponseObj)
                        descriptionClass =  MD_ScopeDescription.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:DQ_Scope') do

                            # scope - level (required)
                            s = hScope[:scopeCode]
                            unless s.nil?
                                @xml.tag!('gmd:level') do
                                    codelistClass.writeXML('gmd', 'iso_scope',s)
                                end
                            end
                            if s.nil?
                                @xml.tag!('gmd:level', {'gco:nilReason'=>'missing'})
                            end

                            # scope - extent [] {EX_Extent}
                            aExtents = hScope[:extents]
                            aExtents.each do |hExtent|
                                @xml.tag!('gmd:extent') do
                                    extentClass.writeXML(hExtent)
                                end
                            end
                            if aExtents.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:extent')
                            end

                            # scope - level description [{MD_ScopeDescription}]
                            aDescription = hScope[:scopeDescriptions]
                            aDescription.each do |hDescription|
                                @xml.tag!('gmd:levelDescription') do
                                    descriptionClass.writeXML(hDescription)
                                end
                            end
                            if aDescription.empty? && @hResponseObj[:writerShowTags]
                                @xml.tag!('gmd:levelDescription')
                            end

                        end # gmd:DQ_Scope tag
                    end # writeXML
                end # DQ_Scope class

            end
        end
    end
end
