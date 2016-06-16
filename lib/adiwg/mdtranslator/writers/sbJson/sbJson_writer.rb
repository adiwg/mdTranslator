require 'jbuilder'
require_relative 'version'
require_relative 'sections/sbJson_base'
require_relative 'sections/sbJson_contact'
require_relative 'sections/sbJson_identifier'
require_relative 'sections/sbJson_spatial'

module ADIWG
  module Mdtranslator
    module Writers
      module SbJson
        extend SbJson::Base
        def self.startWriter(_intObj, responseObj, _paramsObj)
          @intObj = _intObj

          # set output flag for null properties
          Jbuilder.ignore_nil(!responseObj[:writerShowTags])
          # set the format of the output file based on the writer specified
          responseObj[:writerFormat] = 'sbJson'
          responseObj[:writerVersion] = ADIWG::Mdtranslator::Writers::SbJson::VERSION

          rInfo = _intObj[:metadata][:resourceInfo]
          dInfo = _intObj[:metadata][:distributorInfo]
          cite = rInfo[:citation]
          ids = cite[:citResourceIds]

          metadata = Jbuilder.new do |json|
            json.identifiers json_map(ids, Identifier)
            json.title cite[:citTitle]
            json.alternateTitles([cite[:citAltTitle]]) unless cite[:citAltTitle].nil?
            json.body rInfo[:abstract]
            json.citation do
              names = cite[:citResponsibleParty].map do |rp|
                cnt = getContact(rp[:contactId])
                cnt[:indName]
              end
              names = names.select! { |s| s }.nil? ? 'Unknown' : names.join(', ')
              dates = cite[:citDate].map { |dt| dt[:dateTime].strftime('%F') + '(' + dt[:dateType] + ')' }
              url = cite[:citOlResources].map { |ol| ol[:olResURI] }
              json.merge! sprintf('%s, %s, %s, %s', names, dates.join(', '), cite[:citTitle], url.join(', '))
            end
            json.purpose rInfo[:purpose]

            legal = []
            rInfo[:legalConstraints].each do |lc|
              legal += lc[:accessCodes] += lc[:useCodes] += lc[:otherCons]
            end
            json.rights legal.empty? ? nil : legal.join('; ')
            json.provenance do
              json.annotation 'Generated using the ADIwg mdTranslator, http://mdtranslator.adiwg.org'
            end

            mri = []
            dInfo.each { |di| di[:distOrderProcs].each { |dop| mri << dop[:orderInstructions] } }
            json.materialRequestInstructions mri.empty? ? nil : mri.join('; ')

            json.contacts json_map(_intObj[:contacts].select! { |c| !(c[:internal]) }, Contact)

            # grab links from citation, additionalDocumentation, distributionInfo
            wl = []
            wl += cite[:citOlResources]
            dInfo.each { |di| di[:distTransOptions].each { |dto| wl += dto[:online] } }
            _intObj[:metadata][:additionalDocuments].each { |ad| wl += ad[:citation][:citOlResources] }

            json.webLinks(wl) do |lnk|
              json.type 'webLink'
              json.typeLabel 'Web Link'
              json.uri lnk[:olResURI]
              json.title lnk[:olResName]
            end unless wl.empty?

            tags = []
            rInfo[:topicCategories].each do |tc|
              tags << { type: 'Label',
                        scheme: 'ISO 19115 Topic Categories',
                        name: tc }
            end
            rInfo[:descriptiveKeywords].each do |kw|
              type = kw[:keyTheCitation].fetch(:citTitle, kw[:keywordType]) || 'Theme'
              scheme = kw[:keyTheCitation].fetch(:citOlResources, [])
              kw[:keyword].each do |_k|
                tags << { type: type,
                          scheme: scheme.empty? ? 'None' : scheme.first[:olResURI],
                          name: _k }
              end
            end
            json.tags(tags)

            dates = cite[:citDate]
            tp = rInfo[:timePeriod]
            unless  tp.empty?
              dates << { dateType: 'Start', dateTime: tp[:beginTime][:dateTime].to_datetime
              } unless tp[:beginTime].empty?
              dates << { dateType: 'End', dateTime: tp[:endTime][:dateTime].to_datetime
              } unless tp[:endTime].empty?

            end
            json.dates(dates) do |dt|
              json.type dt[:dateType]
              json.dateString dt[:dateTime].strftime('%F')
              json.label dt[:dateType].split(/(?=[A-Z])/).join(' ').capitalize
            end

            json.spatial Spatial.build(rInfo[:extents])
          end
          # set writer pass to true if no messages
          # false or warning will be set by code that places the message
          responseObj[:writerPass] = true if responseObj[:writerMessages].empty?

          # j = JSON.parse(metadata.target!)
          # puts JSON.pretty_generate(j)

          metadata.target!
        end

        # find contact in contact array and return the contact hash
        def self.getContact(contactID)
          @intObj[:contacts].each do |hContact|
            return hContact if hContact[:contactId] == contactID
          end
          {}
        end
      end
    end
  end
end
