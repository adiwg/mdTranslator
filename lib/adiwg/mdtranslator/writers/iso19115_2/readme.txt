
## iso19115_2

### Writer for ISO 19115-2:2009 Geographic Metadata

The mdTranslator iso19115_2 writer implements about 65% of the for ISO 19115-2 standard.
Efforts were made to include all elements of the ISO standard that support general data
descriptions to ensure health and robust project and data metadata records can be created.
The two significant sections not supported by the writer are the Feature Catalogue and
'quantitative' Data Quality sections.

The Feature Catalogue section (which contains entity and attribute
information) is saved as separate file in 19115-2.  This inconvenient implementation was
corrected in the ISO 19115-1:2014 revision and will be supported in the
iso19115_1 writer.
