# MdTranslator - minitest of
# readers / fgdc / module_attribute

# History:
#   Stan Smith 2017-10-31 original script

require 'adiwg/mdtranslator/readers/fgdc/modules/module_fgdc'
require_relative 'fgdc_test_parent'

class TestReaderFgdcDomain < TestReaderFGDCParent

   @@xDoc = TestReaderFGDCParent.get_XML('entityAttribute.xml')
   @@NameSpace = ADIWG::Mdtranslator::Readers::Fgdc::EntityAttribute

   def test_attribute_complete

      TestReaderFGDCParent.set_xDoc(@@xDoc)

      xIn = @@xDoc.xpath('./metadata/eainfo')
      hResponse = Marshal::load(Marshal.dump(@@hResponseObj))
      hDictionary = @@NameSpace.unpack(xIn, hResponse)

      assert_equal 3, hDictionary[:domains].length

      # enumerated domain
      hDomain0 = hDictionary[:domains][0]
      refute_nil hDomain0[:domainId]
      assert_equal 'attribute 1 label', hDomain0[:domainName]
      assert_equal 'attribute 1 label', hDomain0[:domainCode]
      assert_equal 'FGDC enumerated domain', hDomain0[:domainDescription]
      assert_empty hDomain0[:domainReference]
      assert_equal 2, hDomain0[:domainItems].length

      hItem0 = hDomain0[:domainItems][0]
      assert_equal 'attribute 1 enumerated domain value 1', hItem0[:itemName]
      assert_equal 'attribute 1 enumerated domain value 1', hItem0[:itemValue]
      assert_equal 'attribute 1 enumerated domain value 1 definition', hItem0[:itemDefinition]

      hItem1 = hDomain0[:domainItems][1]
      assert_equal 'attribute 1 enumerated domain value 2', hItem1[:itemName]
      assert_equal 'attribute 1 enumerated domain value 2', hItem1[:itemValue]
      assert_equal 'attribute 1 enumerated domain value 2 definition', hItem1[:itemDefinition]

      # codeSet domain
      hDomain1 = hDictionary[:domains][1]
      refute_nil hDomain1[:domainId]
      assert_equal 'codeset name', hDomain1[:domainName]
      assert_equal 'attribute 3 label', hDomain1[:domainCode]
      assert_equal 'FGDC codeSet domain', hDomain1[:domainDescription]
      refute_empty hDomain1[:domainReference]
      assert_equal 'codeset source', hDomain1[:domainReference][:title]
      assert_empty hDomain1[:domainItems]

      # unrepresented domain
      hDomain2 = hDictionary[:domains][2]
      refute_nil hDomain2[:domainId]
      assert_equal 'attribute 4 label', hDomain2[:domainName]
      assert_equal 'attribute 4 label', hDomain2[:domainCode]
      assert_equal 'unrepresented domain description', hDomain2[:domainDescription]
      assert_empty hDomain2[:domainReference]
      assert_empty hDomain2[:domainItems]

      assert hResponse[:readerExecutionPass]
      assert_includes hResponse[:readerExecutionMessages], 'WARNING: FGDC reader: entity type definition source is missing'

   end

end
