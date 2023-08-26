# dcat_us 1.0 writer

# History:
#  Johnathan Aspinwall 2023-06-22 original script

require 'jbuilder'

module ADIWG
   module Mdtranslator
     module Writers
       module Dcat_us
         module Distribution
 
           def self.build(intObj)
             resourceDistributions = intObj.dig(:metadata, :resourceDistribution)
             distributions = []
             stop_iterating = false
 
             resourceDistributions&.each do |resource|
               description = resource[:description] || ''
               resource[:distributor]&.each do |distributor|
                 distributor[:transferOptions]&.each do |transfer|
                   mediaType = transfer.dig(:distributionFormat, :formatSpecification, :title) || ''
                   transfer[:onlineOptions]&.each do |option|
                     if option[:uri]
                        # ToDo:  Need to add a check for .html extension
                       accessURL = option[:uri]
                       downloadURL = option[:uri]
                       title = resource.dig(:distributor, :transferOption, :onlineOption, :name) || ''
                       
                       distribution = Jbuilder.new do |json|
                         json.set!('@type', 'dcat:Distribution')
                         json.set!('dcat:description', description)
                         json.set!('dcat:accessURL', accessURL)
                         json.set!('dcat:downloadURL', downloadURL)
                         json.set!('dcat:mediaType', mediaType)
                         json.set!('dcat:title', title)
                       end
                       distributions << distribution.attributes!
                       stop_iterating = true
                       break
                     end
                   end
                   break if stop_iterating
                 end
                 break if stop_iterating
               end
               stop_iterating = false  # Reset flag for the next resourceDistribution
             end
 
             distributions
           end          
 
         end
       end
     end
   end
 end
 