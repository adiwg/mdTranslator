# MdTranslator - minitest of
# reader / mdJson / module_entityAttribute

# History:
#  Stan Smith 2018-06-18 refactored to use mdJson construction helpers
#  Stan Smith 2017-11-01 added new elements to support fgdc
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2015-07-24 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_entityAttribute'

class TestReaderMdJsonEntityAttribute < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::EntityAttribute

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.entityAttribute
   mdHash[:attributeReference] = TDClass.citation_title
   TDClass.add_valueRange(mdHash, 0, 9)
   TDClass.add_valueRange(mdHash, 'A', 'Z')
   mdHash[:timePeriod] << TDClass.build_timePeriod('TPID001', 'time period one', '2018-06-18')
   mdHash[:timePeriod] << TDClass.build_timePeriod('TPID002', 'time period two', nil, '2018-06-18')

   @@mdHash = mdHash

   # TODO reinstate after schema update
   # def test_entityAttribute_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'entityAttribute.json')
   #     assert_empty errors
   #
   # end

   def test_complete_entityAttribute_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'attribute common name', metadata[:attributeName]
      assert_equal 'attribute code name', metadata[:attributeCode]
      assert_equal 'alias one', metadata[:attributeAlias][0]
      assert_equal 'alias two', metadata[:attributeAlias][1]
      assert_equal 'attribute definition', metadata[:attributeDefinition]
      refute_empty metadata[:attributeReference]
      assert_equal 'title only citation', metadata[:attributeReference][:title]
      assert_equal 'data type', metadata[:dataType]
      refute metadata[:allowNull]
      assert metadata[:mustBeUnique]
      assert_equal 'units of measure', metadata[:unitOfMeasure]
      assert_equal 1.0, metadata[:measureResolution]
      refute metadata[:isCaseSensitive]
      assert_equal 1, metadata[:fieldWidth]
      assert_equal '-1', metadata[:missingValue]
      assert_equal 'DOM001', metadata[:domainId]
      assert_equal '100', metadata[:minValue]
      assert_equal '999', metadata[:maxValue]
      assert_equal 2, metadata[:valueRange].length
      assert_equal 2, metadata[:timePeriod].length

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entityAttribute_codeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['codeName'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary entity attribute code name is missing'

   end

   def test_missing_entityAttribute_codeName

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('codeName')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: data dictionary entity attribute code name is missing'

   end

   def test_empty_entityAttribute_definition

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['definition'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity attribute definition is missing: CONTEXT is attribute code name attribute code name'

   end

   def test_missing_entityAttribute_definition

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('definition')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity attribute definition is missing: CONTEXT is attribute code name attribute code name'

   end

   def test_empty_entityAttribute_dataType

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['dataType'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity attribute data type is missing: CONTEXT is attribute code name attribute code name'

   end

   def test_missing_entityAttribute_dataType

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('dataType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'ERROR: mdJson reader: data dictionary entity attribute data type is missing: CONTEXT is attribute code name attribute code name'

   end

   def test_empty_entityAttribute_cardinality

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['allowNull'] = ''
      hIn['mustBeUnique'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute metadata[:allowNull]
      assert metadata[:mustBeUnique]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_entityAttribute_cardinality

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('allowNull')
      hIn.delete('mustBeUnique')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute metadata[:allowNull]
      assert metadata[:mustBeUnique]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entityAttribute_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['commonName'] = ''
      hIn['alias'] = []
      hIn['attributeReference'] = {}
      hIn['units'] = ''
      hIn['unitsResolution'] = ''
      hIn['isCaseSensitive'] = ''
      hIn['fieldWidth'] = ''
      hIn['missingValue'] = ''
      hIn['domainId'] = ''
      hIn['minValue'] = ''
      hIn['maxValue'] = ''
      hIn['valueRange'] = []
      hIn['timePeriod'] = []

      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:attributeName]
      assert_empty metadata[:attributeAlias]
      assert_empty metadata[:attributeReference]
      assert_nil metadata[:unitOfMeasure]
      assert_nil metadata[:measureResolution]
      refute metadata[:isCaseSensitive]
      assert_nil metadata[:fieldWidth]
      assert_nil metadata[:missingValue]
      assert_nil metadata[:domainId]
      assert_nil metadata[:minValue]
      assert_nil metadata[:maxValue]
      assert_empty metadata[:valueRange]
      assert_empty metadata[:timePeriod]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_entityAttribute_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('commonName')
      hIn.delete('alias')
      hIn.delete('attributeReference')
      hIn.delete('units')
      hIn.delete('unitsResolution')
      hIn.delete('isCaseSensitive')
      hIn.delete('fieldWidth')
      hIn.delete('missingValue')
      hIn.delete('domainId')
      hIn.delete('minValue')
      hIn.delete('maxValue')
      hIn.delete('valueRange')
      hIn.delete('timePeriod')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata[:attributeName]
      assert_empty metadata[:attributeAlias]
      assert_empty metadata[:attributeReference]
      assert_nil metadata[:unitOfMeasure]
      assert_nil metadata[:measureResolution]
      refute metadata[:isCaseSensitive]
      assert_nil metadata[:fieldWidth]
      assert_nil metadata[:missingValue]
      assert_nil metadata[:domainId]
      assert_nil metadata[:minValue]
      assert_nil metadata[:maxValue]
      assert_empty metadata[:valueRange]
      assert_empty metadata[:timePeriod]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_entityAttribute_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: data dictionary entity attribute object is empty'

   end

end
