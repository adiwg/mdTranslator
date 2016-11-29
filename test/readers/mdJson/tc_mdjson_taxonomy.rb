# MdTranslator - minitest of
# reader / mdJson / module_taxonomy

# History:
#   Stan Smith 2016-10-22 original script

require 'minitest/autorun'
require 'json'
require 'adiwg/mdtranslator/internal/internal_metadata_obj'
require 'adiwg/mdtranslator/readers/mdJson/modules/module_taxonomy'

# set contacts to be used by this test
module ADIWG
    module Mdtranslator
        module Readers
            module MdJson
                module MdJson

                    # create new internal metadata container for the reader
                    intMetadataClass = InternalMetadata.new
                    intObj = intMetadataClass.newBase

                    # first contact
                    intObj[:contacts] << intMetadataClass.newContact
                    intObj[:contacts][0][:contactId] = 'individualId0'
                    intObj[:contacts][0][:isOrganization] = false

                    @contacts = intObj[:contacts]

                end
            end
        end
    end
end

class TestReaderMdJsonTaxonomy < MiniTest::Test

    # set constants and variables
    @@NameSpace = ADIWG::Mdtranslator::Readers::MdJson::Taxonomy
    @@responseObj = {
        readerExecutionPass: true,
        readerExecutionMessages: []
    }

    # get json file for tests from examples folder
    file = File.join(File.dirname(__FILE__), 'testData', 'taxonomy.json')
    file = File.open(file, 'r')
    jsonFile = file.read
    file.close
    aIn = JSON.parse(jsonFile)

    # only the first instance in the example array is used for tests
    # the first example is fully populated
    @@hIn = aIn['taxonomy'][0]

    def test_complete_taxonomy_object

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_equal 2, metadata[:taxonSystem].length
        assert_equal 'systemModifications', metadata[:systemMods]
        assert_equal 'generalTaxonomicScope', metadata[:generalScope]
        assert_equal 2, metadata[:idReferences].length
        assert_equal 2, metadata[:observers].length
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_equal 'identificationCompleteness', metadata[:idCompleteness]
        assert_equal 2, metadata[:vouchers].length
        assert_equal 2, metadata[:taxonClasses].length
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_classSystem

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['classificationSystem'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_classSystem

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('classificationSystem')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_idReference

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['identificationReference'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_idReference

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('identificationReference')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_idProcedure

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['identificationProcedure'] = ''
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_idProcedure

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('identificationProcedure')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_taxClass

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['taxonomicClassification'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_taxClass

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('taxonomicClassification')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        assert_nil metadata
        refute hResponse[:readerExecutionPass]
        refute_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_empty_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn['systemModifications'] = ''
        hIn['generalTaxonomicScope'] = ''
        hIn['observer'] = []
        hIn['identificationCompleteness'] = ''
        hIn['voucher'] = []
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:taxonSystem]
        assert_nil metadata[:systemMods]
        assert_nil metadata[:generalScope]
        refute_empty metadata[:idReferences]
        assert_empty metadata[:observers]
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_nil metadata[:idCompleteness]
        assert_empty metadata[:vouchers]
        refute_empty metadata[:taxonClasses]
        assert hResponse[:readerExecutionPass]
        assert_empty hResponse[:readerExecutionMessages]

    end

    def test_taxonomy_missing_elements

        hIn = Marshal::load(Marshal.dump(@@hIn))
        hIn.delete('systemModifications')
        hIn.delete('generalTaxonomicScope')
        hIn.delete('observer')
        hIn.delete('identificationCompleteness')
        hIn.delete('voucher')
        hResponse = Marshal::load(Marshal.dump(@@responseObj))
        metadata = @@NameSpace.unpack(hIn, hResponse)

        refute_empty metadata[:taxonSystem]
        assert_nil metadata[:systemMods]
        assert_nil metadata[:generalScope]
        refute_empty metadata[:idReferences]
        assert_empty metadata[:observers]
        assert_equal 'identificationProcedure', metadata[:idProcedure]
        assert_nil metadata[:idCompleteness]
        assert_empty metadata[:vouchers]
        refute_empty metadata[:taxonClasses]
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