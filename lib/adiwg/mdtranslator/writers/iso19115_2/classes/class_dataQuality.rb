# ISO <<Class>> DQ_DataQuality
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-12-13 refactored for mdTranslator/mdJson 2.0
#   Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#   Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#   Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
# 	Stan Smith 2013-11-20 original script

require_relative 'class_scope'
require_relative 'class_lineage'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class DQ_DataQuality

                    def initialize(xml, responseObj)
                        @xml = xml
                        @hResponseObj = responseObj
                    end

                    def writeXML(hLineage)

                        # classes used
                        scopeClass =  DQ_Scope.new(@xml, @hResponseObj)
                        lineClass =  LI_Lineage.new(@xml, @hResponseObj)

                        @xml.tag!('gmd:DQ_DataQuality') do

                            # data quality - scope {DQ_Scope} (required)
                            hScope = hLineage[:resourceScope]
                            unless hScope.empty?
                                @xml.tag!('gmd:scope') do
                                    scopeClass.writeXML(hScope)
                                end
                            end
                            if hScope.empty?
                                @xml.tag!('gmd:scope', {'gco:nilReason' => 'missing'})
                            end

                            # date quality - report (moved to ISO 19157)

                            # data quality - lineage
                            @xml.tag!('gmd:lineage') do
                                lineClass.writeXML(hLineage)
                            end

                        end # gmd:DQ_DataQuality tag
                    end # writeXML
                end # DQ_DataQuality class

            end
        end
    end
end
