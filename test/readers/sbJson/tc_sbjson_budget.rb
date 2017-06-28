# MdTranslator - minitest of
# reader / sbJson / module_budget

# History:
#   Stan Smith 2017-06-25 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_budget'

class TestReaderSbJsonBudget < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::Budget
   @@hIn = TestReaderSbJsonParent.getJson('budget.json')

   def test_complete_budget

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      hMetadata = @@intMetadataClass.newMetadata

      metadata = @@NameSpace.unpack(hIn, hMetadata, hResponse)

      # sbJson: annualBudgets[]; mdJson: metadata[:funding[]]
      assert_equal 4, metadata[:funding].length

      # complete funding
      hBudget = metadata[:funding][0]

      # sbJson: fundingSources[]; mdJson: allocations[]
      assert_equal 2, hBudget[:allocations].length
      assert_equal 9.0, hBudget[:allocations][0][:amount]
      assert hBudget[:allocations][0][:matching]
      refute hBudget[:allocations][0][:recipient]
      refute hBudget[:allocations][0][:source]
      assert_equal 90.0, hBudget[:allocations][1][:amount]
      refute hBudget[:allocations][1][:matching]

      # sbJson: year; mdJson: timePeriod{}
      hTimePeriod = hBudget[:timePeriod]
      assert_empty hTimePeriod[:startDateTime]
      assert_kind_of DateTime, hTimePeriod[:endDateTime][:dateTime]
      assert_equal 'Y', hTimePeriod[:endDateTime][:dateResolution]

      # year only
      hBudget = metadata[:funding][2]
      assert_empty hBudget[:allocations]
      assert_kind_of DateTime, hTimePeriod[:endDateTime][:dateTime]
      assert_equal 'Y', hTimePeriod[:endDateTime][:dateResolution]

      # allocation only
      hBudget = metadata[:funding][3]
      assert_equal 1, hBudget[:allocations].length
      assert_empty hBudget[:timePeriod]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
