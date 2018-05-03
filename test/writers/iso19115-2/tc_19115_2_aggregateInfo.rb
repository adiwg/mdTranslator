# MdTranslator - minitest of
# writers / iso19115_2 / class_aggregateInformation

# History:
#  Stan Smith 2018-04-12 refactored for error messaging
#  Stan Smith 2017-11-18 replace REXML with Nokogiri
#  Stan Smith 2016-11-21 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152AggregateInfo < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hAssRes1 = TDClass.build_associatedResource('largerWorkCitation', 'associated resource title 1')
   mdHash[:metadata][:associatedResource] = []
   mdHash[:metadata][:associatedResource] << hAssRes1

   @@mdHash = mdHash

   def test_aggregateInfo_complete_first

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_aggregateInfo', '//gmd:aggregationInfo[1]',
                                                '//gmd:aggregationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_aggregateInfo_complete_second

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hAssRes2 = TDClass.build_associatedResource('product', 'associated resource title 2')
      hIn[:metadata][:associatedResource] << hAssRes2

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_aggregateInfo', '//gmd:aggregationInfo[2]',
                                                '//gmd:aggregationInfo', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_aggregateInfo_elements_empty

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:associatedResource][0][:initiativeType] = ''
      hIn[:metadata][:associatedResource][0][:metadataCitation] = {}
      hIn[:metadata][:associatedResource][0][:resourceCitation][:responsibleParty] = []

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_aggregateInfo', '//gmd:aggregationInfo[3]',
                                                '//gmd:aggregationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_aggregateInfo_elements_missing

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hIn[:metadata][:associatedResource][0].delete(:initiativeType)
      hIn[:metadata][:associatedResource][0].delete(:metadataCitation)
      hIn[:metadata][:associatedResource][0][:resourceCitation].delete(:responsibleParty)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_aggregateInfo', '//gmd:aggregationInfo[3]',
                                                '//gmd:aggregationInfo', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
