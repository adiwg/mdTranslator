# sbJson 1.0 writer

# History:
#  Stan Smith 2017-05-30 original script

require 'jbuilder'
require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module WebLink

               def self.buildWebLink(hResource)

                  hWebLink = {}

                  function = hResource[:olResFunction]
                  function = 'download' if function.nil?
                  hWebLink[:type] = Codelists.codelist_iso_to_sb('iso_sb_onlineFunction', :isoCode => function)
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

                  aLinks

               end

            end

         end
      end
   end
end
