# MdTranslator - minitest of
# writers / iso19115_2 / class_scope

# History:
#  Stan Smith 2018-04-24 refactored for error messaging
#  Stan Smith 2017-11-19 replace REXML with Nokogiri
#  Stan Smith 2016-11-21 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152Hierarchy < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   @@mdHash = mdHash

   def test_hierarchyLevel_single

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_hierarchy',
                                                '//gmd:hierarchyLevel[1]',
                                                '//gmd:hierarchyLevel', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_hierarchy',
                                                '//gmd:hierarchyLevelName[1]',
                                                '//gmd:hierarchyLevelName', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_hierarchyLevel_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:resourceType] << { type: 'resource type two', name: 'resource name two'}

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_hierarchy',
                                                '//gmd:hierarchyLevel[3]',
                                                '//gmd:hierarchyLevel', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_hierarchy',
                                                '//gmd:hierarchyLevelName[3]',
                                                '//gmd:hierarchyLevelName', 1)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_hierarchyLevel_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:resourceType][0].delete(:name)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_hierarchy',
                                                '//gmd:hierarchyLevel[4]',
                                                '//gmd:hierarchyLevel', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_hierarchy',
                                                '//gmd:hierarchyLevelName[4]',
                                                '//gmd:hierarchyLevelName', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
