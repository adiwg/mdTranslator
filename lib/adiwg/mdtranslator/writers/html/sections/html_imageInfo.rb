# HTML writer
# image information

# History:
# 	Stan Smith 2015-08-21 original script

require_relative 'html_resourceId'

module ADIWG
    module Mdtranslator
        module Writers
            module Html

                class MdHtmlImageInfo
                    def initialize(html)
                        @html = html
                    end

                    def writeHtml(hImage)

                        # classes used
                        htmlResId = MdHtmlResourceId.new(@html)

                        # image information - illumination elevation angle
                        s = hImage[:illuminationElevationAngle]
                        if !s.nil?
                            @html.em('Illumination elevation angle: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - illumination azimuth angle
                        s = hImage[:illuminationAzimuthAngle]
                        if !s.nil?
                            @html.em('Illumination azimuth angle: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - image condition
                        s = hImage[:imageCondition]
                        if !s.nil?
                            @html.em('Image condition: ')
                            @html.text!(s)
                            @html.br
                        end

                        # image information - image quality
                        hIdentifier = hImage[:imageQuality]
                        if !hIdentifier.empty?
                            @html.em('Image quality: ')
                            @html.section(:class=>'block') do
                                htmlResId.writeHtml(hIdentifier)
                            end
                        end

                        # image information - cloud cover percentage
                        s = hImage[:cloudCoverPercent]
                        if !s.nil?
                            @html.em('Cloud cover percentage: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - compression generation quantity
                        s = hImage[:compressionQuantity]
                        if !s.nil?
                            @html.em('Compression generation quantity: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - triangulation information available
                        s = hImage[:triangulationInfo]
                        if !s.nil?
                            @html.em('Triangulation information available: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - radiometric calibration information available
                        s = hImage[:radiometricCalibrationInfo]
                        if !s.nil?
                            @html.em('Radiometric calibration available: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - camera calibration information available
                        s = hImage[:cameraCalibrationInfo]
                        if !s.nil?
                            @html.em('Camera calibration information available: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - film distortion information available
                        s = hImage[:filmDistortionInfo]
                        if !s.nil?
                            @html.em('Film distortion information available: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                        # image information - lens distortion information available
                        s = hImage[:lensDistortionInfo]
                        if !s.nil?
                            @html.em('Lens distortion information available: ')
                            @html.text!(s.to_s)
                            @html.br
                        end

                    end # writeHtml

                end # class

            end
        end
    end
end
