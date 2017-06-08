# sbJson 1.0 writer publication

# History:
#  Stan Smith 2017-06-03 original script

require 'jbuilder'
require_relative 'sbJson_codelists'

module ADIWG
   module Mdtranslator
      module Writers
         module SbJson

            module Publication

               def self.build(hResource)

                  hPublication = {}

                  # citations for publications
                  hResource[:resourceTypes].each do |hType|
                     type = hType[:type]
                     if type == 'sciencePaper' || type == 'publication'
                        hCitation = hResource[:citation]
                        hPublication[:className] = 'gov.sciencebase.catalog.item.facet.CitationFacet'
                        hPublication[:citationType] = type
                        unless hCitation.empty?
                           unless hCitation[:otherDetails].empty?
                              note = hCitation[:otherDetails][0]
                              hPublication[:note] = note
                           end
                           unless hCitation[:series].empty?
                              series = hCitation[:series]
                              hPublication[:journal] = series[:seriesName] unless series[:seriesName].nil?
                              hPublication[:edition] = series[:seriesIssue] unless series[:seriesIssue].nil?
                              unless series[:issuePage].nil?
                                 hPublication[:parts] = []
                                 part = {}
                                 part[:type] = 'Page Number'
                                 part[:value] = series[:issuePage]
                                 hPublication[:parts] << part
                              end
                           end
                        end
                        unless hResource[:defaultResourceLocale].empty?
                           language = hResource[:defaultResourceLocale][:languageCode]
                           hPublication[:language] = language unless language.nil?
                        end
                     end
                  end

                  hPublication

               end

            end

         end
      end
   end
end
