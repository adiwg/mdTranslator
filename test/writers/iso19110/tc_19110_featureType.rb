# MdTranslator - minitest of
# writers / iso19110 / class_featureType

# History:
#  Stan Smith 2018-04-05 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-03 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110FeatureType < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   # entity EID001 (with indexes)
   hEntity1 = TDClass.build_entity('EID001', 'complete', 'EID001', 'entity 1 definition')
   hAttribute1 = TDClass.build_entityAttribute('attribute one', 'ATT001', 'attribute 001 definition')
   hAttribute2 = TDClass.build_entityAttribute('attribute two', 'ATT002', 'attribute 002 definition')
   hAttribute3 = TDClass.build_entityAttribute('attribute three', 'ATT003', 'attribute 003 definition')
   hEntity1[:attribute] << hAttribute1
   hEntity1[:attribute] << hAttribute2
   hEntity1[:attribute] << hAttribute3
   hEntity1[:primaryKeyAttributeCodeName] = ['ATT001', 'ATT002']
   TDClass.add_dataIndex(hEntity1, 'UIX001', false, ['ATT003'])
   TDClass.add_foreignKey(hEntity1, ['ATT003'], 'EID002', ['ATT004'])
   hCitation1 = TDClass.build_citation('Entity one source')
   hEntity1[:entityReference] << hCitation1
   hDictionary[:entity] << hEntity1

   # entity EID002 (with empty elements)
   hEntity2 = TDClass.build_entity('EID002', nil, 'EID002', 'entity 2 definition')
   hEntity2[:commonName] = ''
   hEntity2[:alias] = []
   hEntity2[:entityReference] = []
   hEntity2[:primaryKeyAttributeCodeName] = []
   hEntity2[:index] = []
   hEntity2[:foreignKey] = []
   hEntity2[:fieldSeparatorCharacter] = ''
   hEntity2[:numberOfHeaderLines] = ''
   hEntity2[:quoteCharacter] = ''
   hDictionary[:entity] << hEntity2

   # entity EID003 (with missing elements)
   hEntity3 = TDClass.build_entity(nil, nil, 'EID003', 'entity 3 definition')
   hEntity3.delete(:entityId)
   hEntity3.delete(:commonName)
   hEntity3.delete(:alias)
   hEntity3.delete(:entityReference)
   hEntity3.delete(:primaryKeyAttributeCodeName)
   hEntity3.delete(:index)
   hEntity3.delete(:foreignKey)
   hEntity3.delete(:fieldSeparatorCharacter)
   hEntity3.delete(:numberOfHeaderLines)
   hEntity3.delete(:quoteCharacter)
   hDictionary[:entity] << hEntity3

   @@mdHash = mdHash
   
   def test_featureType_complete

      hReturn = TestWriter19110Parent.get_complete(@@mdHash, '19110_featureType',
                                                   '//gfc:featureType', '//gfc:featureType')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end
   
end
