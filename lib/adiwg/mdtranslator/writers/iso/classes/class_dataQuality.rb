# ISO <<Class>> DQ_DataQuality
# writer output in XML

# History:
# 	Stan Smith 2013-11-20 original script
#   Stan Smith 2014-07-09 modify require statements to function in RubyGem structure
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
#   Stan Smith 2015-06-11 change all codelists to use 'class_codelist' method

require 'class_codelist'
require 'class_lineage'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso

                class DQ_DataQuality

                    def initialize(xml)
                        @xml = xml
                    end

                    def writeXML(hDataQ)

                        # classes used
                        codelistClass = $IsoNS::MD_Codelist.new(@xml)
                        lineClass = $IsoNS::LI_Lineage.new(@xml)

                        @xml.tag!('gmd:DQ_DataQuality') do

                            # data quality - scope - required
                            s = hDataQ[:dataScope]
                            if s.nil?
                                @xml.tag!('gmd:scope', {'gco:nilReason' => 'missing'})
                            else
                                @xml.tag!('gmd:scope') do
                                    @xml.tag!('gmd:DQ_Scope') do
                                        @xml.tag!('gmd:level') do
                                            codelistClass.writeXML('iso_scope',s)
                                        end
                                    end
                                end
                            end

                            # date quality - report

                            # data quality - lineage
                            hLineage = hDataQ[:dataLineage]
                            if !hLineage.empty?
                                @xml.tag!('gmd:lineage') do
                                    lineClass.writeXML(hLineage)
                                end
                            elsif $showAllTags
                                @xml.tag!('gmd:lineage')
                            end

                        end

                    end

                end

            end
        end
    end
end
