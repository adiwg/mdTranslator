# MdTranslator - minitest of
# writers / iso19110 / class_featureConstraint

# History:
#  Stan Smith 2018-04-05 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-03 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110FeatureConstraint < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # dictionary
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   # entity EID001 (with indexes)
   hEntity1 = TDClass.build_entity('EID001', 'entity one', 'EID001', 'entity 1 definition')
   hAttribute1 = TDClass.build_entityAttribute('attribute one', 'ATT001', 'attribute 001 definition')
   hAttribute2 = TDClass.build_entityAttribute('attribute two', 'ATT002', 'attribute 002 definition')
   hAttribute3 = TDClass.build_entityAttribute('attribute three', 'ATT003', 'attribute 003 definition')
   hEntity1[:attribute] << hAttribute1
   hEntity1[:attribute] << hAttribute2
   hEntity1[:attribute] << hAttribute3
   hEntity1[:primaryKeyAttributeCodeName] = ['ATT001', 'ATT002']
   TDClass.add_dataIndex(hEntity1, 'UIX001', false, ['ATT002', 'ATT003'])
   TDClass.add_dataIndex(hEntity1, 'DIX002', true, ['ATT003'])
   hDictionary[:entity] << hEntity1

   # entity EID002 (with foreign keys)
   hEntity2 = TDClass.build_entity('EID002', 'entity two', 'EID002', 'entity 2 definition')
   hAttribute4 = TDClass.build_entityAttribute('attribute four', 'ATT004', 'attribute 004 definition')
   hAttribute5 = TDClass.build_entityAttribute('attribute five', 'ATT005', 'attribute 005 definition')
   hAttribute6 = TDClass.build_entityAttribute('attribute six', 'ATT006', 'attribute 006 definition')
   hEntity2[:attribute] << hAttribute4
   hEntity2[:attribute] << hAttribute5
   hEntity2[:attribute] << hAttribute6
   hEntity2[:primaryKeyAttributeCodeName] = ['ATT004']
   TDClass.add_foreignKey(hEntity2, ['ATT004'], 'EID001', ['ATT001'])
   TDClass.add_foreignKey(hEntity2, ['ATT004', 'ATT005'], 'EID001', ['ATT001', 'ATT002'])
   hDictionary[:entity] << hEntity2

   @@mdHash = mdHash

   def test_constraint_complete

      hReturn = TestWriter19110Parent.get_complete(@@mdHash, '19110_featureConstraint',
                                                   '//gfc:constrainedBy', '//gfc:constrainedBy')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
