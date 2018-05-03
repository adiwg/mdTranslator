# MdTranslator - minitest of
# writers / iso19110 / class_listedValue

# History:
#  Stan Smith 2018-04-04 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2017-02-03 original script

require_relative 'iso19110_test_parent'
require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'

class TestWriter19110ListedValue < TestWriter19110Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   # listedValue (domain) ---
   # dictionary
   hDictionary = TDClass.build_dataDictionary
   mdHash[:dataDictionary] << hDictionary

   # DOM001 (enumerated)
   hEnumDom1 = TDClass.build_dictionaryDomain('DOM001', 'enumerated domain', 'ENUM')
   TDClass.add_domainItem(hEnumDom1, 'domain item 1', 'value 1','value 1 definition')
   TDClass.add_domainItem(hEnumDom1, 'domain item 2', 'value 2','value 2 definition')
   hDomRef1 = TDClass.build_citation('domain source')
   hItemRef1 = TDClass.build_citation('item source')
   hEnumDom1[:domainReference] = hDomRef1
   hEnumDom1[:domainItem][0][:reference] = hItemRef1
   hDictionary[:domain] << hEnumDom1

   # DOM002 (codeset)
   hCodeSetDom1 = TDClass.build_dictionaryDomain('DOM002', 'codeset domain', 'CODESET')
   hDomRef2 = TDClass.build_citation('codeset source')
   hCodeSetDom1[:domainReference] = hDomRef2
   hDictionary[:domain] << hCodeSetDom1

   # DOM003 (unrepresented)
   hUnRepDom1 = TDClass.build_dictionaryDomain('DOM003', 'unrepresented domain', 'UNREP',
                                               'unrepresented domain description')
   hDictionary[:domain] << hUnRepDom1
   
   # attribute ATT001 (enumerated)
   hAttribute1 = TDClass.build_entityAttribute('enumerated', 'ATT001', 'attribute 001 definition')
   hAttribute1[:domainId] = 'DOM001'
   
   # attribute ATT002 (codelist)
   hAttribute2 = TDClass.build_entityAttribute('codelist', 'ATT002', 'attribute 002 definition')
   hAttribute2[:domainId] = 'DOM002'

   # attribute ATT003 (unrepresented)
   hAttribute3 = TDClass.build_entityAttribute('unrepresented', 'ATT003', 'attribute 003 definition')
   hAttribute3[:domainId] = 'DOM003'

   # entity EID001
   hEntity1 = TDClass.build_entity('EID001', 'entity one', 'EID001', 'entity 1 definition')
   hEntity1[:attribute] << hAttribute1
   hEntity1[:attribute] << hAttribute2
   hEntity1[:attribute] << hAttribute3
   hDictionary[:entity] << hEntity1

   @@mdHash = mdHash


   def test_listedValue_complete

      hReturn = TestWriter19110Parent.run_test(@@mdHash, '19110_listedValue',
                                                   '//gfc:listedValue',
                                                   '//gfc:listedValue')

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]

   end

end
