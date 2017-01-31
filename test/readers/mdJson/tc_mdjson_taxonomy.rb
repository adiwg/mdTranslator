# MdTranslator - minitest of
# reader / mdJson / module_taxonomy

# History:
#   Stan Smith 2017-01-16 added parent class to run successfully within rake
#   Stan Smith 2016-10-22 original script

require_relative 'mdjson_test_parent'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomy'

class TestReaderMdJsonTaxonomy < TestReaderMdJsonParent

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Taxonomy
    aIn = TestReaderMdJsonParent.getJson('taxonomy.json')
    @@hIn = aIn['taxonomy'][0]

    def test_complete_taxonomy_object

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:taxonSystem].length
        assert_equal 'generalScope', metadata[:generalScope]
        assert_equal 2, metadata[:idReferences].length
        assert_equal 2, metadata[:observers].length
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_equal 'identificationCompleteness', metadata[:idCompleteness]
        assert_equal 2, metadata[:vouchers].length
        refute_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_classSystem

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['taxonomicSystem'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_classSystem

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('taxonomicSystem')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_idReference

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['identificationReference'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:taxonSystem].length
        assert_equal 'generalScope', metadata[:generalScope]
        assert_empty metadata[:idReferences]
        assert_equal 2, metadata[:observers].length
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_equal 'identificationCompleteness', metadata[:idCompleteness]
        assert_equal 2, metadata[:vouchers].length
        refute_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_idReference

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('identificationReference')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:taxonSystem].length
        assert_equal 'generalScope', metadata[:generalScope]
        assert_empty metadata[:idReferences]
        assert_equal 2, metadata[:observers].length
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_equal 'identificationCompleteness', metadata[:idCompleteness]
        assert_equal 2, metadata[:vouchers].length
        refute_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_idProcedure

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['identificationProcedure'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_idProcedure

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('identificationProcedure')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_taxClass

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['taxonomicClassification'] = {}
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_taxClass

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('taxonomicClassification')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['generalScope'] = ''
        hIn['observer'] = []
        hIn['identificationCompleteness'] = ''
        hIn['voucher'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:taxonSystem]
        assert_nil metadata[:generalScope]
        refute_empty metadata[:idReferences]
        assert_empty metadata[:observers]
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_nil metadata[:idCompleteness]
        assert_empty metadata[:vouchers]
        refute_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_elements

        TestReaderMdJsonParent.setContacts
        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('generalScope')
        hIn.delete('observer')
        hIn.delete('identificationCompleteness')
        hIn.delete('voucher')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:taxonSystem]
        assert_nil metadata[:generalScope]
        refute_empty metadata[:idReferences]
        assert_empty metadata[:observers]
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_nil metadata[:idCompleteness]
        assert_empty metadata[:vouchers]
        refute_empty metadata[:taxonClass]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_empty_taxonomy_object

        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack({}, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

end