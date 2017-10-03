# MdTranslator - minitest of
# reader / sbJson / module_webLinkGraphic

# History:
#   Stan Smith 2017-06-22 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_webLinkGraphic'

class TestReaderSbJsonWebLinkGraphic < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::WebLinkGraphic
   @@hIn = TestReaderSbJsonParent.getJson('webLink.json')

   def test_complete_webLinkGraph

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata.length

      # first document
      hGraphic = metadata[0]
      assert_equal 'thumbnail', hGraphic[:graphicName]
      assert_equal 'Web-page Thumbnail', hGraphic[:graphicDescription]
      assert_equal 'browseImage', hGraphic[:graphicType]
      assert_equal 1, hGraphic[:graphicURI].length
      hOnRes = hGraphic[:graphicURI][0]
      assert_equal 'http://example.gov/1', hOnRes[:olResURI]

   end

   def test_webLinkGraph_type_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1]['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkGraph_type_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1].delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkGraph_uri_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][2]['uri'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkGraph_uri_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][2].delete('uri')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      assert hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkGraph_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1]['title'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkGraph_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1].delete('title')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
