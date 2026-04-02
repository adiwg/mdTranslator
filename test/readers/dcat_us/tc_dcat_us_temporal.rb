# MdTranslator - minitest of
# reader / dcat_us / module_temporal

require_relative 'dcat_us_test_parent'
require 'adiwg/mdtranslator/readers/dcat_us/modules/module_temporal'

class TestReaderDcatUsTemporal < TestReaderDcatUsParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::Dcat_us::Temporal
   @@hIn = TestReaderDcatUsParent.getDataset('dataset_full.json')

   def test_temporal_start_and_end
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_equal 1, hResourceInfo[:extents].length
      temporal_extents = hResourceInfo[:extents][0][:temporalExtents]
      assert_equal 1, temporal_extents.length
      time_period = temporal_extents[0][:timePeriod]
      assert_equal '2000-01-15T00:45:00Z', time_period[:startDateTime][:dateTime]
      assert_equal '2010-01-15T00:06:00Z', time_period[:endDateTime][:dateTime]
      assert hResponse[:readerExecutionPass]
   end

   def test_temporal_start_only
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn['temporal'] = '2000-01-15'
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      time_period = hResourceInfo[:extents][0][:temporalExtents][0][:timePeriod]
      assert_equal '2000-01-15', time_period[:startDateTime][:dateTime]
      assert_empty time_period[:endDateTime]
   end

   def test_temporal_missing
      hIn           = Marshal.load(Marshal.dump(@@hIn))
      hIn.delete('temporal')
      hResponse     = Marshal.load(Marshal.dump(@@responseObj))
      hResourceInfo = @@intMetadataClass.newResourceInfo

      @@NameSpace.unpack(hIn, hResourceInfo, hResponse)

      assert_empty hResourceInfo[:extents]
   end

end
