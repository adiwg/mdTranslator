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

   # DOM001 (enumerated)
   hEnumDom1 = TDClass.build_dictionaryDomain('DOM001')
   TDClass.add_domainItem(hEnumDom1, nil, 'enumerated value 1','enumerated value 1 definition')
   TDClass.add_domainItem(hEnumDom1, nil, 'enumerated value 2','enumerated value 2 definition')
   hDomRef1 = TDClass.build_citation('domain reference', 'CID001')
   hEnumDom1[:domainReference] = hDomRef1

   # DOM002 (codeset)
   hCodeSetDom1 = TDClass.build_dictionaryDomain('DOM002', 'codeset name', 'codeset code')
   hDomRef2 = TDClass.build_citation('codeset source', 'CID001')
   hCodeSetDom1[:domainReference] = hDomRef2

   # DOM003 (unrepresented)
   hUnRepDom1 = TDClass.build_dictionaryDomain('DOM003', nil, 'unrepresented',
                                               'unrepresented domain description')
   hUnRepDom1.delete(:domainReference)

   # time periods
   hTimePeriod1 = TDClass.build_timePeriod('TP001', 'attribute time range',
                                           '2017-04-01', '2017-04-30')
   hTimePeriod2 = TDClass.build_timePeriod('TP002', 'attribute time range',
                                           '2017-10-01', '2017-10-31')

   # attribute ATT001 (time range)
   hAttribute1 = TDClass.build_entityAttribute(nil, 'ATT001', 'attribute 001 definition')
   hAttrRef1 = TDClass.build_citation('attribute 001 source', 'CID001')
   hAttribute1[:attributeReference] = hAttrRef1
   hAttribute1[:domainId] = 'DOM001'
   hAttribute1[:timePeriod] << hTimePeriod1
   hAttribute1[:timePeriod] << hTimePeriod2

   # attribute ATT002 (value range)
   hAttribute2 = TDClass.build_entityAttribute(nil, 'ATT002', 'attribute 002 definition')
   hAttrRef2 = TDClass.build_citation('attribute 002 source', 'CID001')
   hAttribute2[:attributeReference] = hAttrRef2
   TDClass.add_valueRange(hAttribute2, 0, 9)
   TDClass.add_valueRange(hAttribute2, 20, 40)

   # attribute ATT003
   hAttribute3 = TDClass.build_entityAttribute(nil, 'ATT003', 'attribute 003 definition')
   hAttrRef3 = TDClass.build_citation('attribute 003 source', 'CID001')
   hAttribute3[:attributeReference] = hAttrRef3
   hAttribute3[:domainId] = 'DOM002'

   # attribute ATT004
   hAttribute4 = TDClass.build_entityAttribute(nil, 'ATT004', 'attribute 004 definition')
   hAttrRef4 = TDClass.build_citation('attribute 004 source', 'CID001')
   hAttribute4[:attributeReference] = hAttrRef4
   hAttribute4[:domainId] = 'DOM003'

   # attribute ATT005 (value range)
   hAttribute5 = TDClass.build_entityAttribute(nil, 'ATT005', 'attribute 005 definition')
   hAttrRef5 = TDClass.build_citation('attribute 005 source', 'CID001')
   hAttribute5[:units] = 'grades'
   hAttribute5[:unitsResolution] = 'one letter'
   hAttribute5[:attributeReference] = hAttrRef5
   TDClass.add_valueRange(hAttribute5, 'A', 'F')
   TDClass.add_valueRange(hAttribute5, 'X', 'Z')

   # entity EID001
   hEntity1 = TDClass.build_entity('EID001', nil, 'EID001', 'entity 1 definition')
   hEntRef1 = TDClass.build_citation('entity 001 source', 'CID001')
   hEntity1[:entityReference] << hEntRef1
   hEntity1[:attribute] << hAttribute1
   hEntity1[:attribute] << hAttribute2
   hEntity1[:attribute] << hAttribute3
   hEntity1[:attribute] << hAttribute4
   hEntity1[:attribute] << hAttribute5

   # entity EID002
   hEntity2 = TDClass.build_entity('EID002', nil, 'EID002', 'entity 2 definition')
   hEntRef2 = TDClass.build_citation('entity 002 source', 'CID001')
   hEntity2[:entityReference] << hEntRef2

   # entity EID003
   hEntity3 = TDClass.build_entity('EID003', 'Entity 003 common', 'overview', 'ea overview 1')
   hEntRef30 = TDClass.build_citation('entity 003 overview 1', 'CID001')
   hEntRef31 = TDClass.build_citation('entity 003 overview 2', 'CID001')
   hEntity3[:entityReference] << hEntRef30
   hEntity3[:entityReference] << hEntRef31

   # entity EID004
   hEntity4 = TDClass.build_entity('EID004', 'Entity 004 common', 'overview', 'ea overview 2')
   hEntRef4 = TDClass.build_citation('entity 004 overview 3', 'CID001')
   hEntity4[:entityReference] << hEntRef4

   # dictionary 1
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary
   hDictionary[:domain] << hEnumDom1
   hDictionary[:domain] << hCodeSetDom1
   hDictionary[:domain] << hUnRepDom1
   hDictionary[:entity] << hEntity1
   hDictionary[:entity] << hEntity2
   hDictionary[:entity] << hEntity3
   hDictionary[:entity] << hEntity4

   @@mdHash = mdHash

   def test_dictionary_complete

      hReturn = TestWriterFGDCParent.get_complete(@@mdHash, 'dictionary', './metadata/eainfo')
      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

   # dictionary tests
   def test_dictionary

      # entities empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity] = []

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: data dictionary requires at least one detail or overview entity'

      # entities missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0].delete(:entity)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      refute hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'ERROR: FGDC writer: data dictionary requires at least one detail or overview entity'

   end

   # entity tests
   def test_dictionary_entities

      # entity source empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity][0][:entityReference] = {}

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: entity type definition source is missing'

      # entity source missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity][0].delete(:entityReference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: entity type definition source is missing'

   end

   def test_dictionary_attributes

      # attribute source empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity][0][:attribute][0][:attributeReference] = {}

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: attribute definition source is missing: CONTEXT is entity code EID001'

      # attribute source missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:entity][0][:attribute][0].delete(:attributeReference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: attribute definition source is missing: CONTEXT is entity code EID001'

   end

   def test_dictionary_attribute_domain

      # enum source reference empty
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:domain][0][:domainItem][0][:reference] = {}

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: enumerated domain value source is missing: CONTEXT is DOM001'

      # enum source reference missing
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:dataDictionary][0][:domain][0][:domainItem][0].delete(:reference)

      hResponseObj = ADIWG::Mdtranslator.translate(
         file: hIn.to_json, reader: 'mdJson', writer: 'fgdc', showAllTags: true, validate: 'none'
      )

      refute_empty hResponseObj[:writerOutput]
      assert hResponseObj[:writerPass]
      assert_equal 1, hResponseObj[:writerMessages].length
      assert_includes hResponseObj[:writerMessages],
                      'WARNING: FGDC writer: enumerated domain value source is missing: CONTEXT is DOM001'

   end

end
