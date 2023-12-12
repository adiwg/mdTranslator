# MdTranslator - minitest of
# writers / iso19115_3 / class_series

# History:
#  Stan Smith 2019-05-14 original script

require_relative '../../helpers/mdJson_hash_objects'
require_relative '../../helpers/mdJson_hash_functions'
require_relative 'iso19115_3_test_parent'

class TestWriter191151Series < TestWriter191151Parent

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.base

   mdHash[:metadata][:resourceInfo][:citation] = TDClass.citation_full

   @@mdHash = mdHash

   def test_series_complete

      hIn = Marshal::load(Marshal.dump(@@mdHash))

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_series',
                                                '//cit:series[1]',
                                                '//cit:series', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

   def test_series_elements

      # empty elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hSeries = hIn[:metadata][:resourceInfo][:citation][:series]
      hSeries[:seriesName] = ''
      hSeries[:seriesIssue] = ''
      hSeries[:issuePage] = ''

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_series',
                                                '//cit:series[2]',
                                                '//cit:series', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

      # missing elements
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn[:metadata][:resourceInfo][:citation][:series] = { nonElement: 'nonElement' }

      hReturn = TestWriter191151Parent.run_test(hIn, '19115_3_series',
                                                '//cit:series[2]',
                                                '//cit:series', 2)

      assert_equal hReturn[0], hReturn[1]
      assert hReturn[2]
      assert_empty hReturn[3]

   end

end
