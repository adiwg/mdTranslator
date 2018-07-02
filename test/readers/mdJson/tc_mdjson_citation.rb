# MdTranslator - minitest of
# reader / mdJson / module_citation

# History:
#  Stan Smith 2018-06-15 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-10-13 refactored for mdJson 2.0
#  Stan Smith 2015-06-22 refactored after removal of globals
#  Stan Smith 2014-12-19 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_citation'

class TestReaderMdJsonCitation < TestReaderMdJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Citation

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.citation_full

   @@mdHash = mdHash

   def test_citation_schema

      errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'citation.json')
      assert_empty errors

   end

   def test_complete_citation_object

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 'full citation title', metadata[:title]
      assert_equal 2, metadata[:alternateTitles].length
      assert_equal 'alt title one', metadata[:alternateTitles][0]
      assert_equal 'alt title two', metadata[:alternateTitles][1]
      assert_equal 2, metadata[:dates].length
      assert_equal 'edition', metadata[:edition]
      assert_equal 3, metadata[:responsibleParties].length
      assert_equal 2, metadata[:presentationForms].length
      assert_equal 'form one', metadata[:presentationForms][0]
      assert_equal 'form two', metadata[:presentationForms][1]
      assert_equal 3, metadata[:identifiers].length
      refute_empty metadata[:series]
      assert_equal 2, metadata[:otherDetails].length
      assert_equal 'other detail one', metadata[:otherDetails][0]
      assert_equal 'other detail two', metadata[:otherDetails][1]
      assert_equal 2, metadata[:onlineResources].length
      assert_equal 2, metadata[:browseGraphics].length
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_citation_title

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['title'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: citation title is missing: CONTEXT is testing'

   end

   def test_missing_citation_title

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('title')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: citation title is missing: CONTEXT is testing'

   end

   def test_empty_citation_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['alternateTitle'] = []
      hIn['date'] = []
      hIn['edition'] = ''
      hIn['responsibleParty'] = []
      hIn['presentationForm'] = []
      hIn['identifier'] = []
      hIn['series'] = {}
      hIn['otherCitationDetails'] = []
      hIn['onlineResource'] = []
      hIn['graphic'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'full citation title', metadata[:title]
      assert_empty metadata[:alternateTitles]
      assert_empty metadata[:dates]
      assert_nil metadata[:edition]
      assert_empty metadata[:responsibleParties]
      assert_empty metadata[:presentationForms]
      assert_empty metadata[:identifiers]
      assert_empty metadata[:series]
      assert_empty metadata[:otherDetails]
      assert_empty metadata[:onlineResources]
      assert_empty metadata[:browseGraphics]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_citation_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('alternateTitle')
      hIn.delete('date')
      hIn.delete('edition')
      hIn.delete('responsibleParty')
      hIn.delete('presentationForm')
      hIn.delete('identifier')
      hIn.delete('series')
      hIn.delete('otherCitationDetails')
      hIn.delete('onlineResource')
      hIn.delete('graphic')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse, 'testing')

      assert_equal 'full citation title', metadata[:title]
      assert_empty metadata[:alternateTitles]
      assert_empty metadata[:dates]
      assert_nil metadata[:edition]
      assert_empty metadata[:responsibleParties]
      assert_empty metadata[:presentationForms]
      assert_empty metadata[:identifiers]
      assert_empty metadata[:series]
      assert_empty metadata[:otherDetails]
      assert_empty metadata[:onlineResources]
      assert_empty metadata[:browseGraphics]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_empty_citation_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse, 'testing')

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'WARNING: mdJson reader: citation object is empty: CONTEXT is testing'

   end

end