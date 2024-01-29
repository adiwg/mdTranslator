require_relative 'html_citation'
require_relative 'html_identifier'
require_relative 'html_scope'
require_relative 'html_spatialRepresentation'
require_relative 'html_resultFile'

module ADIWG
  module Mdtranslator
    module Writers
      module Html
        class Html_DataQualityReport
          def initialize(html)
            @html = html
          end

          def writeHtml(hDataQualityReport)
            @html.div(class: 'block') do
              writeQualityMeasure(hDataQualityReport[:qualityMeasure]) unless hDataQualityReport[:qualityMeasure].nil?
            end
            @html.div(class: 'block') do
              writeEvaluationMethod(hDataQualityReport[:evaluationMethod]) unless hDataQualityReport[:evaluationMethod].empty?
            end
            @html.div(class: 'block') do
              writeConformanceResult(hDataQualityReport[:conformanceResult]) unless hDataQualityReport[:conformanceResult].empty?
            end
            @html.div(class: 'block') do
              writeCoverageResult(hDataQualityReport[:coverageResult]) unless hDataQualityReport[:coverageResult].empty?
            end
            @html.div(class: 'block') do
              writeDescriptiveResult(hDataQualityReport[:descriptiveResult]) unless hDataQualityReport[:descriptiveResult].empty?
            end
            @html.div(class: 'block') do
              writeQuantitativeResult(hDataQualityReport[:quantitativeResult]) unless hDataQualityReport[:quantitativeResult].empty?
            end
          end

          private

          def writeQualityMeasure(qualityMeasure)
            identifierClass = Html_Identifier.new(@html)

            @html.div do
              @html.div('Quality Measure', {'class' => 'h5'})
              @html.div(class: 'block') do
                # Identifier
                unless qualityMeasure[:identifier].empty?
                  @html.div do
                    @html.div('Identifier', {'class' => 'h5'})
                    @html.div(class: 'block') do
                      identifierClass.writeHtml(qualityMeasure[:identifier])
                    end
                  end
                end

                # Description
                unless qualityMeasure[:description].nil?
                  @html.em('Description: ')
                  @html.text!(qualityMeasure[:description])
                  @html.br
                end

                # Names
                unless qualityMeasure[:name].empty?
                  @html.em('Names: ')
                  @html.text!(qualityMeasure[:name].join('; '))
                  @html.br
                end
              end
            end
          end

          def writeEvaluationMethod(evaluationMethod)
            citationClass = Html_Citation.new(@html)
          
            @html.div do
              @html.div('Evaluation Method', {'class' => 'h5'})
              evaluationMethod.each do |method|
                @html.div(class: 'block') do
                  # Type
                  unless method[:type].nil?
                    @html.em('Type: ')
                    @html.text!(method[:type])
                    @html.br
                  end
            
                  # DateTime
                  unless method[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(method[:dateTime])
                    @html.br
                  end
            
                  # MethodDescription
                  unless method[:methodDescription].nil?
                    @html.em('Method Description: ')
                    @html.text!(method[:methodDescription])
                    @html.br
                  end
            
                  # EvaluationMethodType
                  unless method[:evaluationMethodType].nil?
                    @html.em('Evaluation Method Type: ')
                    @html.text!(method[:evaluationMethodType])
                    @html.br
                  end
            
                  # DeductiveSource
                  unless method[:deductiveSource].nil?
                    @html.em('Deductive Source: ')
                    @html.text!(method[:deductiveSource])
                    @html.br
                  end
            
                  # SamplingScheme
                  unless method[:samplingScheme].nil?
                    @html.em('Sampling Scheme: ')
                    @html.text!(method[:samplingScheme])
                    @html.br
                  end
            
                  # LotDescription
                  unless method[:lotDescription].nil?
                    @html.em('Lot Description: ')
                    @html.text!(method[:lotDescription])
                    @html.br
                  end
            
                  # SamplingRatio
                  unless method[:samplingRatio].nil?
                    @html.em('Sampling Ratio: ')
                    @html.text!(method[:samplingRatio])
                    @html.br
                  end
            
                  # EvaluationProcedure
                  unless method[:evaluationProcedure].nil? || method[:evaluationProcedure].empty?
                    @html.div do
                      @html.div('Evaluation Procedure', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        citationClass.writeHtml(method[:evaluationProcedure])
                      end
                    end
                  end
            
                  # ReferenceDocument
                  unless method[:referenceDocument].nil? || method[:referenceDocument].empty?
                    @html.div do
                      @html.div('Reference Document', {'class' => 'h5'})
                      method[:referenceDocument].each do |doc|
                        @html.div(class: 'block') do
                          citationClass.writeHtml(doc)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          
          def writeConformanceResult(conformanceResult)
            citationClass = Html_Citation.new(@html)
            scopeClass = Html_Scope.new(@html) # Assuming there's a class to handle scope objects
          
            @html.div do
              @html.div('Conformance Result', {'class' => 'h5'})
              conformanceResult.each do |result|
                @html.div(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil? || result[:scope].empty?
                    @html.div do
                      @html.div('Scope', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        scopeClass.writeHtml(result[:scope])
                      end
                    end
                  end
            
                  # Specification (citation)
                  unless result[:specification].nil?
                    @html.div do
                      @html.div('Specification', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        citationClass.writeHtml(result[:specification])
                      end
                    end
                  end
            
                  # Explanation
                  unless result[:explanation].nil?
                    @html.em('Explanation: ')
                    @html.text!(result[:explanation])
                    @html.br
                  end
            
                  # Pass (boolean)
                  unless result[:pass].nil?
                    @html.em('Pass: ')
                    @html.text!(result[:pass] ? 'Yes' : 'No')
                    @html.br
                  end
                end
              end
            end
          end          

          def writeCoverageResult(coverageResult)
            scopeClass = Html_Scope.new(@html) # Assuming a class to handle scope objects
            spatialRepresentationClass = Html_SpatialRepresentation.new(@html) # Assuming a class to handle spatialRepresentation objects
            resultFileClass = Html_ResultFile.new(@html) # Assuming a class to handle resultFile objects

            @html.div do
              @html.div('Coverage Result', {'class' => 'h5'})
              coverageResult.each do |result|
                @html.div(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil? || result[:scope].empty?
                    @html.div do
                      @html.div('Scope', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        scopeClass.writeHtml(result[:scope])
                      end
                    end
                  end
            
                  # SpatialRepresentationType
                  unless result[:spatialRepresentationType].nil? || result[:spatialRepresentationType].empty?
                    @html.em('Spatial Representation Type: ')
                    @html.text!(result[:spatialRepresentationType])
                    @html.br
                  end
            
                  # SpatialRepresentation
                  unless result[:spatialRepresentation].nil? || result[:spatialRepresentation].empty?
                    @html.div do
                      @html.div('Spatial Representation', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        spatialRepresentationClass.writeHtml(result[:spatialRepresentation])
                      end
                    end
                  end
            
                  # ResultContent
                  unless result[:resultContent].nil? || result[:resultContent].empty?
                    @html.em('Result Content: ')
                    result[:resultContent].each do |content|
                      @html.text!(content)
                      @html.br
                    end
                  end
            
                  # ResourceFormat
                  unless result[:resourceFormat].nil?
                    @html.em('Resource Format: ')
                    @html.text!(result[:resourceFormat])
                    @html.br
                  end
            
                  # ResultFile
                  unless result[:resultFile].nil?
                    @html.em('Result File: ')
                    @html.div(class: 'block') do
                      resultFileClass.writeHtml(result[:resultFile])
                    end
                  end
                end
              end
            end
          end          

          def writeDescriptiveResult(descriptiveResult)
            scopeClass = Html_Scope.new(@html) # Assuming a class to handle scope objects
          
            @html.div do
              @html.div('Descriptive Result', {'class' => 'h5'})
              descriptiveResult.each do |result|
                @html.div(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil?
                    @html.div do
                      @html.div('Scope', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        scopeClass.writeHtml(result[:scope])
                      end
                    end
                  end
            
                  # Statement
                  unless result[:statement].nil?
                    @html.em('Statement: ')
                    @html.text!(result[:statement])
                    @html.br
                  end
                end
              end
            end
          end          

          def writeQuantitativeResult(quantitativeResult)
            scopeClass = Html_Scope.new(@html) # Assuming a class to handle scope objects
          
            @html.div do
              @html.div('Quantitative Result', {'class' => 'h5'})
              quantitativeResult.each do |result|
                @html.div(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil?
                    @html.div do
                      @html.div('Scope', {'class' => 'h5'})
                      @html.div(class: 'block') do
                        scopeClass.writeHtml(result[:scope])
                      end
                    end
                  end
            
                  # Value
                  unless result[:value].nil? || result[:value].empty?
                    @html.em('Value: ')
                    @html.text!(result[:value].join(', '))
                    @html.br
                  end
            
                  # ValueUnits
                  unless result[:valueUnits].nil?
                    @html.em('Value Units: ')
                    @html.text!(result[:valueUnits])
                    @html.br
                  end
            
                  # ValueRecordType
                  unless result[:valueRecordType].nil?
                    @html.em('Value Record Type: ')
                    @html.text!(result[:valueRecordType])
                    @html.br
                  end
                end
              end
            end
          end
          
        end
      end
    end
  end
end
