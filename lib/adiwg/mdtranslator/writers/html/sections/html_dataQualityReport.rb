require_relative 'html_citation'
require_relative 'html_identifier'
require_relative 'html_scope'
require_relative 'html_spatialRepresentation'
require_relative 'html_format'
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
            @html.section(class: 'block') do
              writeQualityMeasure(hDataQualityReport[:qualityMeasure]) unless hDataQualityReport[:qualityMeasure].nil?
            end
            @html.section(class: 'block') do
              writeEvaluationMethod(hDataQualityReport[:evaluationMethod]) unless hDataQualityReport[:evaluationMethod].empty?
            end
            @html.section(class: 'block') do
              writeConformanceResult(hDataQualityReport[:conformanceResult]) unless hDataQualityReport[:conformanceResult].empty?
            end
            @html.section(class: 'block') do
              writeCoverageResult(hDataQualityReport[:coverageResult]) unless hDataQualityReport[:coverageResult].empty?
            end
            @html.section(class: 'block') do
              writeDescriptiveResult(hDataQualityReport[:descriptiveResult]) unless hDataQualityReport[:descriptiveResult].empty?
            end
            @html.section(class: 'block') do
              writeQuantitativeResult(hDataQualityReport[:quantitativeResult]) unless hDataQualityReport[:quantitativeResult].empty?
            end
          end

          private

          def writeQualityMeasure(qualityMeasure)
            identifierClass = Html_Identifier.new(@html)

            @html.details do
              @html.summary('Quality Measure', {'class' => 'h5'})
              @html.section(class: 'block') do
                # Identifier
                unless qualityMeasure[:identifier].empty?
                  @html.details do
                    @html.summary('Identifier', {'class' => 'h5'})
                    @html.section(class: 'block') do
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
          
            @html.details do
              @html.summary('Evaluation Method', {'class' => 'h5'})
              @html.section(class: 'block') do
                # Type
                unless evaluationMethod[:type].nil?
                  @html.em('Type: ')
                  @html.text!(evaluationMethod[:type])
                  @html.br
                end
          
                # DateTime
                unless evaluationMethod[:dateTime].nil?
                  @html.em('Date Time: ')
                  evaluationMethod[:dateTime].each do |datetime|
                    @html.text!(datetime)
                    @html.br
                  end
                end
          
                # MethodDescription
                unless evaluationMethod[:methodDescription].nil?
                  @html.em('evaluationMethod Description: ')
                  @html.text!(evaluationMethod[:methodDescription])
                  @html.br
                end
          
                # EvaluationMethodType
                unless evaluationMethod[:evaluationMethodType].nil?
                  @html.em('Evaluation evaluationMethod Type: ')
                  @html.text!(evaluationMethod[:evaluationMethodType])
                  @html.br
                end
          
                # DeductiveSource
                unless evaluationMethod[:deductiveSource].nil?
                  @html.em('Deductive Source: ')
                  @html.text!(evaluationMethod[:deductiveSource])
                  @html.br
                end
          
                # SamplingScheme
                unless evaluationMethod[:samplingScheme].nil?
                  @html.em('Sampling Scheme: ')
                  @html.text!(evaluationMethod[:samplingScheme])
                  @html.br
                end
          
                # LotDescription
                unless evaluationMethod[:lotDescription].nil?
                  @html.em('Lot Description: ')
                  @html.text!(evaluationMethod[:lotDescription])
                  @html.br
                end
          
                # SamplingRatio
                unless evaluationMethod[:samplingRatio].nil?
                  @html.em('Sampling Ratio: ')
                  @html.text!(evaluationMethod[:samplingRatio])
                  @html.br
                end
          
                # EvaluationProcedure
                unless evaluationMethod[:evaluationProcedure].nil? || evaluationMethod[:evaluationProcedure].empty?
                  @html.details do
                    @html.summary('Evaluation Procedure', {'class' => 'h5'})
                    @html.section(class: 'block') do
                      citationClass.writeHtml(evaluationMethod[:evaluationProcedure])
                    end
                  end
                end
          
                # ReferenceDocument
                unless evaluationMethod[:referenceDocument].nil? || evaluationMethod[:referenceDocument].empty?
                  @html.details do
                    @html.summary('Reference Document', {'class' => 'h5'})
                    evaluationMethod[:referenceDocument].each do |doc|
                      @html.section(class: 'block') do
                        citationClass.writeHtml(doc)
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
          
            @html.details do
              @html.summary('Conformance Result', {'class' => 'h5'})
              conformanceResult.each do |result|
                @html.section(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil? || result[:scope].empty?
                    @html.details do
                      @html.summary('Scope', {'class' => 'h5'})
                      @html.section(class: 'block') do
                        scopeClass.writeHtml(result[:scope])
                      end
                    end
                  end
            
                  # Specification (citation)
                  unless result[:specification].nil?
                    @html.details do
                      @html.summary('Specification', {'class' => 'h5'})
                      @html.section(class: 'block') do
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
            formatClass = Html_Format.new(@html)
            resultFileClass = Html_ResultFile.new(@html)

            @html.details do
              @html.summary('Coverage Result', {'class' => 'h5'})
              coverageResult.each do |result|
                @html.section(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil? || result[:scope].empty?
                    @html.details do
                      @html.summary('Scope', {'class' => 'h5'})
                      @html.section(class: 'block') do
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
                    @html.details do
                      @html.summary('Spatial Representation', {'class' => 'h5'})
                      @html.section(class: 'block') do
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
                    @html.section(class: 'block') do
                      formatClass.writeHtml(result[:resourceFormat])
                    end
                  end
            
                  # ResultFile
                  unless result[:resultFile].nil?
                    @html.em('Result File: ')
                    @html.section(class: 'block') do
                      resultFileClass.writeHtml(result[:resultFile])
                    end
                  end
                end
              end
            end
          end          

          def writeDescriptiveResult(descriptiveResult)
            scopeClass = Html_Scope.new(@html) # Assuming a class to handle scope objects
          
            @html.details do
              @html.summary('Descriptive Result', {'class' => 'h5'})
              descriptiveResult.each do |result|
                @html.section(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil?
                    @html.details do
                      @html.summary('Scope', {'class' => 'h5'})
                      @html.section(class: 'block') do
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
          
            @html.details do
              @html.summary('Quantitative Result', {'class' => 'h5'})
              quantitativeResult.each do |result|
                @html.section(class: 'block') do
                  # DateTime
                  unless result[:dateTime].nil?
                    @html.em('Date Time: ')
                    @html.text!(result[:dateTime])
                    @html.br
                  end
            
                  # Scope
                  unless result[:scope].nil?
                    @html.details do
                      @html.summary('Scope', {'class' => 'h5'})
                      @html.section(class: 'block') do
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
