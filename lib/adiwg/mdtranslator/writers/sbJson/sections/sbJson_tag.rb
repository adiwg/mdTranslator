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

               def self.build(hResource)

                  aTags = []

                  # tags from resource type
                  hResource[:resourceTypes].each do |hType|
                     hTag = {}
                     type = hType[:type]
                     sbType = Codelists.codelist_iso_to_sb('iso_sb_scope', :isoCode => type)
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

                  # tags for projects
                  hResource[:resourceTypes].each do |hType|
                     type = hType[:type]
                     if type == 'project'
                        hResource[:status].each do |status|
                           # TODO don't translate, push out all
                           sbStatus = Codelists.codelist_iso_to_sb('iso_sb_progress', :isoCode => status)
                           unless sbStatus.nil?
                              hTag = {}
                              # TODO just status
                              hTag[:type] = 'Project Status'
                              hTag[:name] = sbStatus
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
