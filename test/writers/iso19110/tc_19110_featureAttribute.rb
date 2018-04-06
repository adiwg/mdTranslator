# MdTranslator - minitest of
# writers / iso19110 / class_featureAttribute (attribute)

# History:
#  Stan Smith 2018-04-04 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-02 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110FeatureAttribute < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   # attribute ATT001 
   hAttribute1 = TDClass.build_entityAttribute('complete', 'ATT001', 'attribute 001 definition')
   hSource1 = TDClass.build_citation('attribute 1 citation')
   hAttribute1[:attributeReference] = hSource1
   
   # attribute ATT002 
   hAttribute2 = TDClass.build_entityAttribute(nil, 'ATT002', 'attribute 002 definition')
   hAttribute2[:commonName] = ''
   hAttribute2[:alias] = []
   hAttribute2[:units] = ''
   hAttribute2[:unitsResolution] = ''
   hAttribute2[:fieldWidth] = ''
   hAttribute2[:missingValue] = ''
   hAttribute2[:domainId] = ''
   hAttribute2[:minValue] = ''
   hAttribute2[:maxValue] = ''

   # attribute ATT003
   hAttribute3 = TDClass.build_entityAttribute(nil, 'ATT003', 'attribute 003 definition')
   hAttribute3.delete(:commonName)
   hAttribute3.delete(:alias)
   hAttribute3.delete(:units)
   hAttribute3.delete(:unitsResolution)
   hAttribute3.delete(:fieldWidth)
   hAttribute3.delete(:missingValue)
   hAttribute3.delete(:domainId)
   hAttribute3.delete(:minValue)
   hAttribute3.delete(:maxValue)
   hAttribute3.delete(:valueRange)
   hAttribute3.delete(:timePeriod)

   # entity EID001
   hEntity1 = TDClass.build_entity('EID001', 'entity 1', 'EID001', 'entity 1 definition')
   hEntity1[:attribute] << hAttribute1
   hEntity1[:attribute] << hAttribute2
   hEntity1[:attribute] << hAttribute3
   hDictionary[:entity] << hEntity1

   @@mdHash = mdHash

   def test_attribute_complete

      hReturn = TestWriter19110Parent.get_complete(@@mdHash, '19110_featureAttribute',
                                                   '//gfc:carrierOfCharacteristics',
                                                   '//gfc:carrierOfCharacteristics')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   def test_attribute_elements

      # elements empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity][0][:attribute].delete_at(0)
      hIn[:dataDictionary][0][:entity][0][:attribute].delete_at(1)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'iso19110', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: attribute common name is missing: CONTEXT is ATT002'

      # elements missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity][0][:attribute].delete_at(0)
      hIn[:dataDictionary][0][:entity][0][:attribute].delete_at(0)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'iso19110', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: ISO-19110 writer: attribute common name is missing: CONTEXT is ATT003'

   end

end
