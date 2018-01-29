# MdTranslator - minitest of
# writers / fgdc / class_dictionary

# History:
#  Stan Smith 2018-01-22 original script

require_relative 'fgdc_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriterFgdcDictionary < TestWriterFGDCParent

   # instance classes needed in script
   TDClass = FgdcWriterTD.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   hEnumDom1 = TDClass.build_dictionaryDomain('DOM001')
   TDClass.add_domainItem(hEnumDom1, nil, 'domain 1 enum value 1', 'domain 1 enum value 1 definition')
   TDClass.add_domainItem(hEnumDom1, nil, 'domain 1 enum value 2', 'domain 1 enum value 2 definition')
   hEnumDom1[:domainItem][1].delete(:reference)
   hDictionary[:domain] << hEnumDom1

   hTimePeriod1 = TDClass.build_timePeriod('TP001', 'attribute time range', '2017-04-01', '2017-04-30')
   hTimePeriod2 = TDClass.build_timePeriod('TP002', 'attribute time range', '2017-10-01', '2017-10-31')

   hAttribute1 = TDClass.build_entityAttribute(nil, 'attribute 1 label', 'attribute 1 definition')
   hCitation1 = TDClass.build_citation('attribute 1 source', 'CID001')
   hAttribute1[:attributeReference] = hCitation1
   hAttribute1[:domainId] = 'DOM001'
   hAttribute1[:timePeriod] << hTimePeriod1
   hAttribute1[:timePeriod] << hTimePeriod2

   hAttribute2 = TDClass.build_entityAttribute(nil, 'attribute 2 label', 'attribute 2 definition')
   hCitation2 = TDClass.build_citation('attribute 2 source', 'CID001')
   hAttribute2[:attributeReference] = hCitation2
   TDClass.add_valueRange(hAttribute2, 0, 9)
   TDClass.add_valueRange(hAttribute2, 20, 40)

   hCodeSetDom1 = TDClass.build_dictionaryDomain('DOM002', 'codeset name', 'codeset code')
   hCitation4 = TDClass.build_citation('codeset source', 'CID001')
   hCodeSetDom1[:domainReference] = hCitation4
   hDictionary[:domain] << hCodeSetDom1

   hAttribute3 = TDClass.build_entityAttribute(nil, 'attribute 3 label', 'attribute 3 definition')
   hCitation3 = TDClass.build_citation('attribute 3 source', 'CID001')
   hAttribute3[:attributeReference] = hCitation3
   hAttribute3[:domainId] = 'DOM002'

   hUnRepDom1 = TDClass.build_dictionaryDomain('DOM003', nil, 'unrepresented', 'unrepresented domain description')
   hDictionary[:domain] << hUnRepDom1

   hAttribute4 = TDClass.build_entityAttribute(nil, 'attribute 4 label', 'attribute 4 definition')
   hCitation4 = TDClass.build_citation('attribute 4 source', 'CID001')
   hAttribute4[:attributeReference] = hCitation4
   hAttribute4[:domainId] = 'DOM003'

   hAttribute5 = TDClass.build_entityAttribute(nil, 'attribute 5 label', 'attribute 5 definition')
   hCitation5 = TDClass.build_citation('attribute 5 source', 'CID001')
   hAttribute5[:units] = 'grades'
   hAttribute5[:unitsResolution] = 'one letter'
   hAttribute5[:attributeReference] = hCitation5
   TDClass.add_valueRange(hAttribute5, 'A', 'F')
   TDClass.add_valueRange(hAttribute5, 'X', 'Z')

   hEntity1 = TDClass.build_entity('EID001', nil, 'entity 1 label', 'entity 1 definition')
   hCitation10 = TDClass.build_citation('entity 1 source', 'CID001')
   hEntity1[:entityReference] << hCitation10
   hEntity1[:attribute] << hAttribute1
   hEntity1[:attribute] << hAttribute2
   hEntity1[:attribute] << hAttribute3
   hEntity1[:attribute] << hAttribute4
   hEntity1[:attribute] << hAttribute5

   hDictionary[:entity] << hEntity1

   hEntity2 = TDClass.build_entity('EID002', nil, 'entity 2 label', 'entity 2 definition')
   hCitation20 = TDClass.build_citation('entity 2 source', 'CID001')
   hEntity2[:entityReference] << hCitation20

   hDictionary[:entity] << hEntity2

   hEntity3 = TDClass.build_entity('EID003', 'Entity Overview', 'overview', 'ea overview 1')
   hCitation30 = TDClass.build_citation('ea overview 1 citation 1', 'CID001')
   hCitation31 = TDClass.build_citation('ea overview 1 citation 2', 'CID001')
   hEntity3[:entityReference] << hCitation30
   hEntity3[:entityReference] << hCitation31

   hDictionary[:entity] << hEntity3

   hEntity4 = TDClass.build_entity('EID004', 'Entity Overview', 'overview', 'ea overview 2')
   hCitation40 = TDClass.build_citation('ea overview 2 citation 1', 'CID001')
   hEntity4[:entityReference] << hCitation40

   hDictionary[:entity] << hEntity4

   @@mdHash = mdHash

   def test_dictionary_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'dictionary', './metadata/eainfo')
      assert_equal hReturn[0], hReturn[1]

   end

end
