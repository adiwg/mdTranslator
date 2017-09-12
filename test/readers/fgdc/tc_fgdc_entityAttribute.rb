# MdTranslator - minitest of
# readers / fgdc / module_entityAttribute

# History:
#   Stan Smith 2017-09-06 original script

require 'nokogiri'
require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcEntityAttribute < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_entityAttribute_complete

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hDictionary = @@NameSpace.unpack(xIn, @@hResponseObj)

      refute_empty hDictionary
      refute_empty hDictionary[:citation]
      assert_equal 'FGDC EntityAttribute Section 5', hDictionary[:citation][:title]
      assert_equal 1, hDictionary[:domains].length
      assert_equal 4, hDictionary[:entities].length
      assert @@hResponseObj[:readerExecutionPass]
      assert_empty @@hResponseObj[:readerExecutionMessages]

   end

end
