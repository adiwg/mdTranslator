# MdTranslator - minitest of
# writers / iso19115_1 / class_scope

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151Scope < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage

   hScope = hLineage[:scope]
   hScope[:scopeDescription] << { dataset: 'dataset one' }
   hScope[:scopeDescription] << { other: 'other one' }
   hScope[:scopeExtent] << TDClass.build_extent('scope extent one')
   hScope[:scopeExtent] << TDClass.build_extent('scope extent two')

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_scope_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hScope = hIn[:metadata][:resourceLineage][0][:scope]
      hScope[:scopeDescription].delete_at(1)
      hScope[:scopeExtent].delete_at(1)
      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_scope',
                                                '//mrl:scope[1]',
                                                '//mrl:scope', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_scope_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_scope',
                                                '//mrl:scope[2]',
                                                '//mrl:scope', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_scope_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # empty elements
      hIn[:metadata][:resourceLineage][0][:scope][:scopeDescription] = []
      hIn[:metadata][:resourceLineage][0][:scope][:scopeExtent] = []

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_scope',
                                                '//mrl:scope[3]',
                                                '//mrl:scope', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn[:metadata][:resourceLineage][0][:scope].delete(:scopeDescription)
      hIn[:metadata][:resourceLineage][0][:scope].delete(:scopeExtent)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_scope',
                                                '//mrl:scope[3]',
                                                '//mrl:scope', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
