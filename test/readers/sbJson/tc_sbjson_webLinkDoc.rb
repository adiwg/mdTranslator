# MdTranslator - minitest of
# reader / sbJson / module_webLinkDocument

# History:
#   Stan Smith 2017-06-22 original script

require_relative 'sbjson_test_parent'
require 'adiwg/mdtranslator/readers/sbJson/modules/module_webLinkDocument'

class TestReaderSbJsonWebLinkDocument < TestReaderSbJsonParent

   @@NameSpace = ADIWG::Mdtranslator::Readers::SbJson::WebLinkDocs
   @@hIn = TestReaderSbJsonParent.getJson('webLink.json')

   def test_complete_webLinkDoc

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 3, metadata.length

      # first document
      hDocument = metadata[0]
      assert_equal 1, hDocument[:resourceTypes].length
      assert_equal 'publicationReferenceSource', hDocument[:resourceTypes][0][:type]
      assert_equal 'Publication that references this resource', hDocument[:resourceTypes][0][:name]
      assert_equal 1, hDocument[:citation].length
      hCitation = hDocument[:citation][0]
      assert_equal 'Projected wetland densities', hCitation[:title]
      assert_equal 1, hCitation[:onlineResources].length
      hOnRes = hCitation[:onlineResources][0]
      assert_equal 'https://doi.org/10.1890/15-0750.1', hOnRes[:olResURI]

      # second document
      hDocument = metadata[1]
      hCitation = hDocument[:citation][0]
      assert_equal 'Online Resource', hCitation[:title]

      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkDoc_type_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1]['type'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkDoc_type_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1].delete('type')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkDoc_uri_empty

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1]['uri'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkDoc_uri_missing

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1].delete('uri')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      refute_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkDoc_empty_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1]['title'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_webLinkDoc_missing_elements

      hIn = Marshal::load(Marshal.dump(@@hIn))
      hIn['webLinks'][1].delete('title')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))

      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

end
