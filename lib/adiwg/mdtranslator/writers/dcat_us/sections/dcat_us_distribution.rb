require 'jbuilder'
require_relative 'dcat_us_access_url'
require_relative 'dcat_us_download_url'
require_relative 'dcat_us_media_type'


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

                  mediaType = MediaType.build(transfer)

                  transfer[:onlineOptions]&.each do |option|
                    next unless option[:olResURI]
                    accessURL = AccessURL.build(option)
                    downloadURL = DownloadURL.build(option)
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
