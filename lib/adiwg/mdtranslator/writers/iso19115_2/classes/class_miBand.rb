# ISO <<Class>> MI_Band attributes
# 19115-2 writer output in XML

# History:
#   Stan Smith 2016-11-29 refactored for mdTranslator/mdJson 2.0
# 	Stan Smith 2015-08-27 original script.

require_relative 'class_codelist'

module ADIWG
    module Mdtranslator
        module Writers
            module Iso19115_2

                class MI_Band

                    def initialize(xml, hResponseObj)
                        @xml = xml
                        @hResponseObj = hResponseObj
                    end

                    def writeXML(hAttribute)

                        # classes used
                        codelistClass = MD_Codelist.new(@xml, @hResponseObj)

                        # miBand - band boundary definition {MI_BandDefinition}
                        s = hAttribute[:bandBoundaryDefinition]
                        unless s.nil?
                            @xml.tag!('gmi:bandBoundaryDefinition') do
                                codelistClass.writeXML('iso_bandDefinition',s)
                            end
                        end

                        # miBand - nominal spatial resolution {real}
                        s = hAttribute[:nominalSpatialResolution]
                        unless s.nil?
                            @xml.tag!('gmi:nominalSpatialResolution') do
                                @xml.tag!('gco:Real',s)
                            end
                        end

                        # miBand - transfer function type code
                        # {MI_TransferFunctionTypeCode}
                        s = hAttribute[:transferFunctionType]
                        unless s.nil?
                            @xml.tag!('gmi:transferFunctionType') do
                                codelistClass.writeXML('iso_transferFunctionTypeCode',s)
                            end
                        end

                        # miBand - transmitted polarization orientation code
                        # {MI_PolarizationOrientationCode}
                        s = hAttribute[:transmittedPolarization]
                        unless s.nil?
                            @xml.tag!('gmi:transmittedPolarization') do
                                codelistClass.writeXML('iso_polarizationOrientationCode',s)
                            end
                        end

                        # miBand - detected polarization orientation code
                        # {MI_PolarizationOrientationCode}
                        s = hAttribute[:detectedPolarization]
                        unless s.nil?
                            @xml.tag!('gmi:detectedPolarization') do
                                codelistClass.writeXML('iso_polarizationOrientationCode',s)
                            end
                        end

                    end # writeXML
                end # MI_Band attributes

            end
        end
    end
end