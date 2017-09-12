# MdTranslator - minitest of
# readers / fgdc / module_process

# History:
#   Stan Smith 2017-08-31 original script

require 'nokogiri'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcProcess < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('lineage.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::Lineage

   def test_process_complete

      intMetadataClass = InternalMetadata.new
      hResourceInfo = intMetadataClass.newResourceInfo

      TestReaderFGDCParent.set_xDoc(@@xDoc)
      TestReaderFGDCParent.set_intObj
      xIn = @@xDoc.xpath('./metadata/dataqual/lineage')
      hLineage = @@NameSpace.unpack(xIn, hResourceInfo,@@hResponseObj)

      refute_nil hLineage

      aSteps = hLineage[:processSteps]
      assert_equal 2, aSteps.length

      hProcess = aSteps[0]
      refute_empty hProcess
      assert_nil hProcess[:stepId]
      assert_equal 'my proc step 1 description', hProcess[:description]
      assert_nil hProcess[:rationale]
      refute_empty hProcess[:timePeriod]
      assert_equal 1, hProcess[:processors].length
      assert_equal 2, hProcess[:stepSources].length
      assert_equal 1, hProcess[:stepProducts].length
      assert_empty hProcess[:scope]

      hTimePeriod = hProcess[:timePeriod]
      assert_equal 'Step completion dateTime', hTimePeriod[:description]
      assert_empty hTimePeriod[:startDateTime]
      refute_empty hTimePeriod[:endDateTime]

      hProcessor = hProcess[:processors][0]
      assert_equal 'processor', hProcessor[:roleName]
      assert_empty hProcessor[:roleExtents]
      assert_equal 1, hProcessor[:parties].length

      hSource = hProcess[:stepSources][0]
      assert_equal 'my source 1 contribution', hSource[:description]

      hProduct = hProcess[:stepProducts][0]
      assert_equal 'my source 2 contribution', hProduct[:description]

      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
