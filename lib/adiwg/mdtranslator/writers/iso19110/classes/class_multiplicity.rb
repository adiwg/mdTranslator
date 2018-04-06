# ISO <<Class>> Multiplicity & MultiplicityRange
# writer output in XML
# definition: cardinality (0..1, 0..*, 1..1, 1..*)
# uncertain how this is used for attributes of relational tables since
# ... cardinality is defined between tables, not for attributes.
# ... documentation by NOAA and modelManager suggest best practice for
# ... propertyType is to default to 1.
# ... upper not provided a value in examples but XSD required it to be present
# ... I assume this is using cardinality like optionality.
# ... therefore ...
# ... lower = 0 if allowNull = false
# ... lower = 1 if allowNull = true
# ... upper = 1 if mustBeUnique = true
# ... upper = 9 if mustBeUnique = false with isInfinite="true"

# History:
#  Stan Smith 2018-02-14 add isInfinite="true" to upper multiplicity
#  Stan Smith 2017-02-02 refactored for mdJson/mdTranslator 2.0
#  Stan Smith 2015-07-14 refactored to eliminate namespace globals $WriterNS and $IsoNS
#  Stan Smith 2015-07-14 refactored to make iso19110 independent of iso19115_2 classes
#  Stan Smith 2015-06-22 replace global ($response) with passed in object (responseObj)
#  Stan Smith 2014-12-12 refactored to handle namespacing readers and writers
# 	Stan Smith 2014-12-02 original script.

module ADIWG
   module Mdtranslator
      module Writers
         module Iso19110

            class Multiplicity

               def initialize(xml, responseObj)
                  @xml = xml
                  @hResponseObj = responseObj
               end

               def writeXML(hAttribute)

                  # xml for iso classes Multiplicity and MultiplicityRange
                  # in 19110 cardinality is expressed as multiplicity, a min/max range
                  # Multiplicity is not defined in the documentation, only inferred from the XSD
                  # max cardinality -----------------
                  # ISO 19110-2 rule
                  # ... "If this is an attribute or operation, the default cardinality is 1"
                  # there is no hint if this refers to min or max of the range, I chose max
                  # I assume this means the attribute can occur only once in the entity
                  # I set the internal object mustBeUnique = true as default
                  # I assume false would describe something like a repeating tag in an XML file
                  # min cardinality -----------------
                  # mdJson allows setting flag to allow nulls as attribute values
                  # I set this into minimum cardinality
                  # issue ---------------------------
                  # min cardinality refers to the attribute values
                  # max cardinality refers to the attribute instantiation
                  # perhaps one of these should not be carried in ISO19110

                  minCard = 1
                  maxCard = 9
                  if hAttribute[:allowNull]
                     minCard = 0
                  end
                  if hAttribute[:mustBeUnique]
                     maxCard = 1
                  end

                  # xml for iso classes Multiplicity and MultiplicityRange
                  @xml.tag!('gco:Multiplicity') do

                     @xml.tag!('gco:range') do
                        @xml.tag!('gco:MultiplicityRange') do
                           @xml.tag!('gco:lower') do
                              @xml.tag!('gco:Integer', minCard)
                           end
                           @xml.tag!('gco:upper') do
                              if maxCard == 1
                                 @xml.tag!('gco:UnlimitedInteger', 1)
                              else
                                 @xml.tag!('gco:UnlimitedInteger', {'isInfinite'=>'true'}, 9)
                              end
                           end
                        end
                     end

                  end # gco:Multiplicity tag
               end # writeXML
            end # Multiplicity class

         end
      end
   end
end
