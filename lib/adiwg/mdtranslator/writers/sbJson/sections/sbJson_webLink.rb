# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-30 original script

require 'jbuilder'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_codelists'
require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module WebLink

               @Namespace = ADIWG::Mdtranslator::Readers::SbJson

               def self.buildWebLink(hResource)

                  hWebLink = {}

                  function = hResource[:olResFunction]
                  if function.nil?
                     hWebLink[:type] = 'webLink'
                  else
                     if @Namespace::Codelists.is_sb_code('onlineFunction_sb2adiwg', function)
                        hWebLink[:type] = function
                     else
                        sbFunction = Codelists.codelist_adiwg2sb('onlineFunction_adiwg2sb', function)
                        hWebLink[:type] = sbFunction.nil? ? 'webLink' : sbFunction
                     end
                  end

                  hWebLink[:typeLabel] = hResource[:olResDesc] unless hResource[:olResDesc].nil?
                  hWebLink[:uri] = hResource[:olResURI] unless hResource[:olResURI].nil?
                  hWebLink[:title] = hResource[:olResName] unless hResource[:olResName].nil?

                  hWebLink

               end

               def self.build(hMetadata)

                  aLinks = []

                  # build webLinks from additionalDocumentation
                  hMetadata[:additionalDocuments].each do |hDocument|
                     hDocument[:citation].each do |hCitation|
                        hCitation[:onlineResources].each do |hResource|
                           hWebLink = buildWebLink(hResource)
                           aLinks << hWebLink unless hWebLink.empty?
                        end
                     end
                  end

                  # build webLinks from graphic
                  hMetadata[:resourceInfo][:graphicOverviews].each do |hGraphic|
                     hGraphic[:graphicURI].each do |hResource|
                        hWebLink = buildWebLink(hResource)
                        aLinks << hWebLink unless hWebLink.empty?
                     end
                  end

                  # build webLinks from distributor
                  hMetadata[:distributorInfo].each do |aDistribution|
                     aDistribution[:distributor].each do |aDistributor|
                        aDistributor[:transferOptions].each do |aOption|
                           aOption[:onlineOptions].each do |hResource|
                              hWebLink = buildWebLink(hResource)
                              aLinks << hWebLink unless hWebLink.empty?
                           end
                        end
                     end
                  end

                  if aLinks.empty?
                     return nil
                  end

                  aLinks

               end

            end

         end
      end
   end
end
