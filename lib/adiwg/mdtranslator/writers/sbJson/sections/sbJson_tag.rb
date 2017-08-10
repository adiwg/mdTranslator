# sbJson 1.0 writer tags

# History:
#  Stan Smith 2017-05-31 original script

require 'jbuilder'
require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Tag

               def self.build(intObj)

                  hResource = intObj[:metadata][:resourceInfo]
                  aTags = []

                  # tags from resource type
                  hResource[:resourceTypes].each do |hType|
                     hTag = {}
                     type = hType[:type]
                     sbType = Codelists.codelist_adiwg2sb('scope_adiwg2sb', type)
                     sbType = sbType.nil? ? type : sbType
                     hTag[:type] = 'Resource Type'
                     hTag[:name] = sbType
                     aTags << hTag
                  end

                  # tags from keywords
                  hResource[:keywords].each do |hThemeSet|
                     theme = hThemeSet[:keywordType]
                     scheme = nil
                     hThesaurus = hThemeSet[:thesaurus]
                     unless hThesaurus.empty?
                        unless hThesaurus[:onlineResources].empty?
                           scheme = hThesaurus[:onlineResources][0][:olResURI]
                        end
                     end
                     hThemeSet[:keywords].each do |hKeywordObj|
                        hTag = {}
                        hTag[:type] = theme unless theme.nil?
                        hTag[:name] = hKeywordObj[:keyword]
                        hTag[:scheme] = scheme unless scheme.nil?
                        if theme == 'isoTopicCategory'
                           hTag[:type] = hTag[:scheme] = 'ISO 19115 Topic Categories'
                        end
                        aTags << hTag
                     end
                  end

                  # tags from status
                  hResource[:status].each do |status|
                     hTag = {}
                     hTag[:type] = 'Status'
                     hTag[:name] = status
                     aTags << hTag
                  end

                  # tags from repositories
                  intObj[:metadataRepositories].each do |hRepo|
                     if hRepo[:repository] == 'data.gov'
                        unless hRepo[:citation].empty?
                           tagName = nil
                           tagName = hRepo[:citation][:title] unless hRepo[:citation][:title].nil?
                           unless tagName.nil?
                              hTag = {}
                              hTag[:type] = 'Harvest Set'
                              hTag[:name] = tagName
                              aTags << hTag
                           end
                        end
                     end
                  end

                  if aTags.empty?
                     return nil
                  end

                  aTags

               end

            end

         end
      end
   end
end
