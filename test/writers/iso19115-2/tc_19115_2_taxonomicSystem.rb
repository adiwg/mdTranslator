# MdTranslator - minitest of
# writers / iso19115_2 / class_taxonomicSystem

# History:
#  Stan Smith 2018-05-01 refactored for error messaging
#  Stan Smith 2017-11-20 replace REXML with Nokogiri
#  Stan Smith 2017-01-13 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_2_test_parent'

class TestWriter191152TaxonomicSystem < TestWriter191152Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hTaxonomy = TDClass.taxonomy

   mdHash[:metadata][:resourceInfo][:taxonomy] = []
   mdHash[:metadata][:resourceInfo][:taxonomy] << hTaxonomy

   TDClass.removeEmptyObjects(mdHash)

   @@mdHash = mdHash

   def test_taxonomicSystem_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomicSystem',
                                                '//gmd:classSys[1]',
                                                '//gmd:classSys', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_taxonomicSystem_missing_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:taxonomy][0][:taxonomicSystem][0].delete(:modifications)

      hReturn = TestWriter191152Parent.run_test(hIn, '19115_2_taxonomicSystem',
                                                '//gmd:classSys[2]',
                                                '//gmd:classSys', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
