# ISO <<Class>> DQ_Scope
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 original script

require_relative 'class_codelist'
require_relative 'class_timePeriod'
require_relative 'class_scopeDescription'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class DQ_Scope

                    def initialize(xml, responseObj)
                        @xml = xml
                        @responseObj = responseObj
                    end

                    def writeXML(hScope)

                        # classes used
                        codelistClass =  MD_Codelist.new(@xml, @responseObj)
                        periodClass =  TimePeriod.new(@xml, @responseObj)
                        descriptionClass =  MD_ScopeDescription.new(@xml, @responseObj)

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

                            # scope - extent {[TimePeriod]}
                            aPeriods = hScope[:timePeriod]
                            unless aPeriods.empty?
                                @xml.tag!('gmd:extent') do
                                    @xml.tag!('gmd:EX_Extent') do
                                        aPeriods.each do |hPeriod|
                                            @xml.tag!('gmd:temporalElement') do
                                                @xml.tag!('gmd:EX_TemporalExtent') do
                                                    @xml.tag!('gmd:extent') do
                                                        periodClass.writeXML(hPeriod)
                                                    end
                                                end
                                            end
                                        end
                                    end
                                end
                            end
                            if aPeriods.empty? && @responseObj[:writerShowTags]
                                @xml.tag!('gmd:extent')
                            end

                            # scope - level description [{MD_ScopeDescription}]
                            aDescription = hScope[:scopeDescription]
                            aDescription.each do |hDescription|
                                @xml.tag!('gmd:levelDescription') do
                                    descriptionClass.writeXML(hDescription)
                                end
                            end
                            if aDescription.empty? && @responseObj[:writerShowTags]
                                @xml.tag!('gmd:levelDescription')
                            end

                        end # gmd:DQ_Scope tag
                    end # writeXML
                end # DQ_Scope class

            end
        end
    end
end
