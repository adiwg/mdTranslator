# Reader - fgdc to internal data structure
# unpack fgdc taxonomy

# History:
#  Stan Smith 2017-09-20 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require_relative 'module_keyword'
require_relative 'module_taxonSystem'
require_relative 'module_taxonClass'

module ADIWG
   module Mdtranslator
      module Readers
         module Fgdc

            module Taxonomy

               def self.unpack(xTaxonomy, hResourceInfo, hResponseObj)

                  # instance classes needed in script
                  intMetadataClass = InternalMetadata.new
                  hTaxonomy = intMetadataClass.newTaxonomy

                  # taxonomy bio.1 (keywtax) - taxonomic keywords [] {keyword} (required)
                  # -> resourceInfo.keywords
                  axKeywords = xTaxonomy.xpath('./keywtax')
                  unless axKeywords.empty?
                     axKeywords.each do |xKeyword|
                        Keyword.unpack(xKeyword, hResourceInfo, hResponseObj)
                     end
                  end
                  if axKeywords.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC BIO taxonomy keywords are missing'
                  end

                  # taxonomy bio.2 (taxonsys) - taxonomic system
                  xSystem = xTaxonomy.xpath('./taxonsys')
                  unless xSystem.empty?
                     TaxonSystem.unpack(xSystem, hTaxonomy, hResponseObj)
                  end

                  # taxonomy bio.3 (taxongen) - general taxonomic coverage
                  # -> resourceInfo.taxonomy.generalScope
                  general = xTaxonomy.xpath('./taxongen').text
                  unless general.empty?
                     hTaxonomy[:generalScope] = general
                  end

                  # taxonomy bio.4 (taxoncl) - taxonomic classification (required)
                  # -> resourceInfo.taxonomy.taxonClass
                  xTaxClass = xTaxonomy.xpath('./taxoncl')
                  unless xTaxClass.empty?
                     hTaxonClass = TaxonClass.unpack(xTaxClass, hResponseObj)
                     unless hTaxonClass.nil?
                        hTaxonomy[:taxonClass] = hTaxonClass
                     end
                  end
                  if xTaxClass.empty?
                     hResponseObj[:readerExecutionMessages] << 'WARNING: FGDC BIO taxonomy classification is missing'
                  end

                  return hTaxonomy

               end

            end

         end
      end
   end
end
