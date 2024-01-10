require 'jbuilder'

module ADIWG
  module Mdtranslator
    module Writers
      module Dcat_us
        module Distribution

          def self.build(intObj)
            resourceDistributions = intObj.dig(:metadata, :distributorInfo)
            distributions = []

            resourceDistributions&.each do |resource|
              description = resource[:description] || ''
              break_flag = false  # Flag to control nested loop breaks

              resource[:distributor]&.each do |distributor|
                break if break_flag

                distributor[:transferOptions]&.each do |transfer|
                  break if break_flag

                  mediaType = transfer.dig(:distributionFormats)&.find { |format| format.dig(:formatSpecification, :title) }&.dig(:formatSpecification, :title) || ''

                  transfer[:onlineOptions]&.each do |option|
                    next unless option[:olResURI]

                    accessURL = option[:olResURI] unless option[:olResURI].end_with?('.html')
                    downloadURL = option[:olResURI] if option[:olResURI].end_with?('.html')
                    title = option[:olResName] || ''

                    distribution = Jbuilder.new do |json|
                      json.set!('@type', 'dcat:Distribution')
                      json.set!('description', description)
                      json.set!('accessURL', accessURL) if accessURL
                      json.set!('downloadURL', downloadURL) if downloadURL
                      json.set!('mediaType', mediaType)
                      json.set!('title', title)
                    end

                    distributions << distribution.attributes!
                    break_flag = true
                    break
                  end
                end
              end
            end
            distributions
          end

        end
      end
    end
  end
end
