# sbJson 1.0 writer

# History:
#  Stan Smith 2017-11-30 added citation and metadata online resources to webLinks
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

               def self.build_webLink(hResource)

                  hWebLink = {}

                  function = hResource[:olResFunction]
                  # if function is nil use sbJson type 'webLink'
                  # if function was entered as a valid sbJson code use it
                  # if function was entered as a valid ADIwg/ISO code translate it to sbJson
                  # if the translation is not possible use sbJson type 'webLink'
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

                  # build webLinks from metadataLinkages
                  hMetadata[:metadataInfo][:metadataLinkages].each do |hResource|
                     hWebLink = build_webLink(hResource)
                     aLinks << hWebLink unless hWebLink.empty?
                  end

                  # build webLinks from resourceInfo[:citation][:onlineResources]
                  hMetadata[:resourceInfo][:citation][:onlineResources].each do |hResource|
                     hWebLink = build_webLink(hResource)
                     aLinks << hWebLink unless hWebLink.empty?
                  end

                  # build webLinks from additionalDocumentation
                  hMetadata[:additionalDocuments].each do |hDocument|
                     hDocument[:citation].each do |hCitation|
                        hCitation[:onlineResources].each do |hResource|
                           hWebLink = build_webLink(hResource)
                           aLinks << hWebLink unless hWebLink.empty?
                        end
                     end
                  end

                  # build webLinks from graphic
                  hMetadata[:resourceInfo][:graphicOverviews].each do |hGraphic|
                     hGraphic[:graphicURI].each do |hResource|
                        hWebLink = build_webLink(hResource)
                        aLinks << hWebLink unless hWebLink.empty?
                     end
                  end

                  # build webLinks from distributor
                  hMetadata[:distributorInfo].each do |aDistribution|
                     aDistribution[:distributor].each do |aDistributor|
                        aDistributor[:transferOptions].each do |aOption|
                           aOption[:onlineOptions].each do |hResource|
                              hWebLink = build_webLink(hResource)
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
