# MdTranslator - minitest of
# writers / iso19115_1 / class_liSource

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_1_test_parent'

class TestWriter191151liSource < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   hLineage = TDClass.lineage

   # build sources
   hLineage[:source] << TDClass.build_liSource_full

   mdHash[:metadata][:resourceLineage] = []
   mdHash[:metadata][:resourceLineage] << hLineage

   @@mdHash = mdHash

   def test_source_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hSource = hIn[:metadata][:resourceLineage][0][:source][0]
      hSource[:metadataCitation].delete_at(1)
      hSource[:sourceProcessStep].delete_at(1)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liSource',
                                                '//mrl:LI_Source[1]',
                                                '//mrl:LI_Source', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_source_complete_multiple

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liSource',
                                                '//mrl:LI_Source[2]',
                                                '//mrl:LI_Source', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_source_elements

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      # empty elements
      hSource = hIn[:metadata][:resourceLineage][0][:source][0]
      hSource[:sourceId] = ''
      # hSource[:description] = ''
      hSource[:sourceCitation] = {}
      hSource[:metadataCitation] = []
      hSource[:spatialResolution] = {}
      hSource[:referenceSystem] = {}
      hSource[:sourceProcessStep] = []
      hSource[:scope] = {}

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liSource',
                                                '//mrl:LI_Source[3]',
                                                '//mrl:LI_Source', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hSource.delete(:sourceId)
      # hSource.delete(:description)
      hSource.delete(:sourceCitation)
      hSource.delete(:metadataCitation)
      hSource.delete(:spatialResolution)
      hSource.delete(:referenceSystem)
      hSource.delete(:sourceProcessStep)
      hSource.delete(:scope)

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_1_liSource',
                                                '//mrl:LI_Source[3]',
                                                '//mrl:LI_Source', 0)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
