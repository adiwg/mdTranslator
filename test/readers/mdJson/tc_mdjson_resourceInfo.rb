# MdTranslator - minitest of
# reader / mdJson / module_resourceInfo

# History:
#  Stan Smith 2018-06-24 refactored to use mdJson construction helpers
#  Stan Smith 2017-01-16 added parent class to run successfully within rake
#  Stan Smith 2016-11-01 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_resourceInfo'

class TestReaderMdJsonResourceInfo < TestReaderMdJsonParent

   # set constants and variables
   @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::ResourceInfo

   # instance classes needed in script
   TDClass = MdJsonHashWriter.new

   # build mdJson test file in hash
   mdHash = TDClass.build_resourceInfo_full

   @@mdHash = mdHash

   # def test_resourceInfo_schema
   #
   #     errors = TestReaderMdJsonParent.testSchema(@@mdHash, 'resourceInfo.json')
   #     assert_empty errors
   #
   # end

   def test_complete_resourceInfo

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      assert_equal 2, metadata[:resourceTypes].length
      refute_empty metadata[:citation]
      assert_equal 'abstract', metadata[:abstract]
      assert_equal 'short abstract', metadata[:shortAbstract]
      assert_equal 'purpose', metadata[:purpose]
      assert_equal 2, metadata[:credits].length
      refute_empty metadata[:timePeriod]
      assert_equal 2, metadata[:status].length
      assert_equal 2, metadata[:pointOfContacts].length
      assert_equal 2, metadata[:spatialReferenceSystems].length
      assert_equal 2, metadata[:spatialRepresentationTypes].length
      assert_equal 2, metadata[:spatialRepresentations].length
      assert_equal 2, metadata[:spatialResolutions].length
      assert_equal 2, metadata[:temporalResolutions].length
      assert_equal 2, metadata[:extents].length
      assert_equal 2, metadata[:coverageDescriptions].length
      assert_equal 2, metadata[:taxonomy].length
      assert_equal 2, metadata[:graphicOverviews].length
      assert_equal 2, metadata[:resourceFormats].length
      assert_equal 2, metadata[:keywords].length
      assert_equal 2, metadata[:resourceUsages].length
      assert_equal 2, metadata[:constraints].length
      refute_empty metadata[:defaultResourceLocale]
      assert_equal 2, metadata[:otherResourceLocales].length
      assert_equal 2, metadata[:resourceMaintenance].length
      assert_equal 'environment description', metadata[:environmentDescription]
      assert_equal 'supplemental information', metadata[:supplementalInfo]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]
   end

   def test_empty_resourceInfo_type

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['resourceType'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource type is missing: CONTEXT is resource information'

   end

   def test_missing_resourceInfo_type

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('resourceType')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource type is missing: CONTEXT is resource information'

   end

   def test_empty_resourceInfo_citation

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['citation'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource citation is missing: CONTEXT is resource information'

   end

   def test_missing_resourceInfo_citation

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('citation')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource citation is missing: CONTEXT is resource information'

   end

   def test_empty_resourceInfo_abstract

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['abstract'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource abstract is missing: CONTEXT is resource information'

   end

   def test_missing_resourceInfo_abstract

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('abstract')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource abstract is missing: CONTEXT is resource information'

   end

   def test_empty_resourceInfo_contact

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('topicCategory')
      hIn['pointOfContact'] = []
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource point-of-contact is missing: CONTEXT is resource information'

   end

   def test_missing_resourceInfo_contact

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('topicCategory')
      hIn.delete('pointOfContact')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource point-of-contact is missing: CONTEXT is resource information'

   end

   def test_empty_resourceInfo_locale

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('topicCategory')
      hIn['defaultResourceLocale'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource default locale is missing: CONTEXT is resource information'

   end

   def test_missing_resourceInfo_locale

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('topicCategory')
      hIn.delete('defaultResourceLocale')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource default locale is missing: CONTEXT is resource information'

   end

   def test_empty_resourceInfo_status

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['status'] = {}
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource status is missing: CONTEXT is resource information'

   end

   def test_missing_resourceInfo_status

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('status')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource status is missing: CONTEXT is resource information'

   end

   def test_empty_resourceInfo_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['shortAbstract'] = ''
      hIn['purpose'] = ''
      hIn['timePeriod'] = {}
      hIn['credit'] = []
      hIn['topicCategory'] = []
      hIn['spatialReferenceSystem'] = []
      hIn['spatialRepresentationType'] = []
      hIn['spatialRepresentation'] = []
      hIn['spatialResolution'] = []
      hIn['temporalResolution'] = []
      hIn['extent'] = []
      hIn['coverageDescription'] = []
      hIn['taxonomy'] = []
      hIn['graphicOverview'] = []
      hIn['resourceFormat'] = []
      hIn['keyword'] = []
      hIn['resourceUsage'] = []
      hIn['constraint'] = []
      hIn['otherResourceLocale'] = []
      hIn['resourceMaintenance'] = []
      hIn['environmentDescription'] = ''
      hIn['supplementalInfo'] = ''
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:resourceTypes]
      refute_empty metadata[:citation]
      assert_equal 'abstract', metadata[:abstract]
      assert_nil metadata[:shortAbstract]
      assert_nil metadata[:purpose]
      assert_empty metadata[:credits]
      assert_empty metadata[:timePeriod]
      refute_empty metadata[:pointOfContacts]
      assert_empty metadata[:spatialReferenceSystems]
      assert_empty metadata[:spatialRepresentationTypes]
      assert_empty metadata[:spatialRepresentations]
      assert_empty metadata[:spatialResolutions]
      assert_empty metadata[:temporalResolutions]
      assert_empty metadata[:extents]
      assert_empty metadata[:coverageDescriptions]
      assert_empty metadata[:taxonomy]
      assert_empty metadata[:graphicOverviews]
      assert_empty metadata[:resourceFormats]
      assert_empty metadata[:keywords]
      assert_empty metadata[:resourceUsages]
      assert_empty metadata[:constraints]
      refute_empty metadata[:defaultResourceLocale]
      assert_empty metadata[:otherResourceLocales]
      assert_empty metadata[:resourceMaintenance]
      assert_nil metadata[:environmentDescription]
      assert_nil metadata[:supplementalInfo]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_missing_resourceInfo_elements

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn.delete('shortAbstract')
      hIn.delete('purpose')
      hIn.delete('timePeriod')
      hIn.delete('credit')
      hIn.delete('topicCategory')
      hIn.delete('spatialReferenceSystem')
      hIn.delete('spatialRepresentationType')
      hIn.delete('spatialRepresentation')
      hIn.delete('spatialResolution')
      hIn.delete('temporalResolution')
      hIn.delete('extent')
      hIn.delete('coverageDescription')
      hIn.delete('taxonomy')
      hIn.delete('graphicOverview')
      hIn.delete('resourceFormat')
      hIn.delete('keyword')
      hIn.delete('resourceUsage')
      hIn.delete('constraint')
      hIn.delete('otherResourceLocale')
      hIn.delete('resourceMaintenance')
      hIn.delete('environmentDescription')
      hIn.delete('supplementalInfo')
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_empty metadata[:resourceTypes]
      refute_empty metadata[:citation]
      assert_equal 'abstract', metadata[:abstract]
      assert_nil metadata[:shortAbstract]
      assert_nil metadata[:purpose]
      assert_empty metadata[:credits]
      assert_empty metadata[:timePeriod]
      refute_empty metadata[:pointOfContacts]
      assert_empty metadata[:spatialReferenceSystems]
      assert_empty metadata[:spatialRepresentationTypes]
      assert_empty metadata[:spatialRepresentations]
      assert_empty metadata[:spatialResolutions]
      assert_empty metadata[:temporalResolutions]
      assert_empty metadata[:extents]
      assert_empty metadata[:coverageDescriptions]
      assert_empty metadata[:taxonomy]
      assert_empty metadata[:graphicOverviews]
      assert_empty metadata[:resourceFormats]
      assert_empty metadata[:keywords]
      assert_empty metadata[:resourceUsages]
      assert_empty metadata[:constraints]
      refute_empty metadata[:defaultResourceLocale]
      assert_empty metadata[:otherResourceLocales]
      assert_empty metadata[:resourceMaintenance]
      assert_nil metadata[:environmentDescription]
      assert_nil metadata[:supplementalInfo]
      assert hResponse[:readerExecutionPass]
      assert_empty hResponse[:readerExecutionMessages]

   end

   def test_taxonomy_object_deprecated

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hTaxonomy = hIn['taxonomy'][0]
      hIn['taxonomy'] = {}
      hIn['taxonomy'] = hTaxonomy
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         'NOTICE: mdJson reader: taxonomy is now an array, the single taxonomy object was deprecated: CONTEXT is resource information'

   end

   def test_topicCategory_deprecated

      TestReaderMdJsonParent.loadEssential
      hIn = Marshal::load(Marshal.dump(@@mdHash))
      hIn = JSON.parse(hIn.to_json)
      hIn['topicCategory'] = ['topic category one', 'topic category two']
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack(hIn, hResponse)

      refute_nil metadata
      assert hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
         "NOTICE: mdJson reader: topicCategory is deprecated, items were moved to keywords, keywordType 'isoTopicCategory': CONTEXT is resource information"
   end

   def test_empty_resourceInfo_object

      TestReaderMdJsonParent.loadEssential
      hResponse = Marshal::load(Marshal.dump(@@responseObj))
      metadata = @@NameSpace.unpack({}, hResponse)

      assert_nil metadata
      refute hResponse[:readerExecutionPass]
      assert_equal 1, hResponse[:readerExecutionMessages].length
      assert_includes hResponse[:readerExecutionMessages],
                      'ERROR: mdJson reader: resource info object is empty'

   end

end
