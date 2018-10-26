class MdJsonHashWriter

   # rules -----------------------------------
   # >> base will have meet all requirements for a valid ISO and FGDC metadata record
   # >> ruby hash objects will equal their mdJson counterparts
   # >> all string elements will be loaded with values
   # >> required objects will be loaded with corresponding object, e.g.  { citation: citation }
   # >> non-required objects will be empty
   # >> required arrays will be loaded with 1 elements
   # >> non-required arrays will be empty

   # base ------------------------------------
   def base
      {
         schema: {
            name: 'mdJson',
            version: '2.4.0'
         },
         contact: [
            {
               contactId: 'CID001',
               isOrganization: false,
               name: 'person name',
               positionName: 'position name',
               phone: [
                  {
                     phoneName: 'phone name',
                     phoneNumber: '111-111-1111',
                     service: ['voice']
                  }
               ],
               address: [
                  {
                     addressType: [
                        'mailing'
                     ],
                     description: 'address description',
                     deliveryPoint: [
                        'address line 1',
                        'address line 2'
                     ],
                     city: 'city',
                     administrativeArea: 'administrative area',
                     postalCode: 'postal code',
                     country: 'country'
                  }
               ]
            },
            {
               contactId: 'CID002',
               isOrganization: true,
               name: 'organization name',
               phone: [
                  {
                     phoneName: 'phone name',
                     phoneNumber: '222-222-2222',
                     service: ['voice']
                  }
               ],
               address: [
                  {
                     addressType: [
                        'mailing'
                     ],
                     description: 'address description',
                     deliveryPoint: [
                        'address line 1',
                        'address line 2'
                     ],
                     city: 'city',
                     administrativeArea: 'administrative area',
                     postalCode: 'postal code',
                     country: 'country'
                  }
               ]
            },
            {
               contactId: 'CID003',
               isOrganization: false,
               name: 'person name three'
            },
            {
               contactId: 'CID004',
               isOrganization: true,
               name: 'organization name four'
            }
         ],
         metadata: {
            metadataInfo: {
               metadataContact: [
                  {
                     role: 'pointOfContact',
                     party: [
                        {
                           contactId: 'CID001'
                        }
                     ]
                  }
               ],
               metadataDate: [
                  {
                     'date': '2018-01-26',
                     'dateType': 'creation'
                  }
               ],
            },
            resourceInfo: {
               resourceType: [
                  {
                     type: 'resource type',
                     name: 'resource name'
                  }
               ],
               citation: {
                  title: 'citation title',
                  date: [
                     {
                        'date': '2017-11-22',
                        'dateType': 'publication'
                     }
                  ],
                  responsibleParty: [
                     {
                        role: 'originator',
                        party: [
                           {
                              contactId: 'CID001'
                           }
                        ]
                     }
                  ]
               },
               abstract: 'abstract',
               purpose: 'purpose',
               timePeriod: {
                  description: 'resource time period',
                  startDateTime: '2017-12-01'
               },
               status: [
                  'status 1'
               ],
               extent: [
                  geographicExtent: [
                     {
                        description: 'FGDC spatial domain',
                        containsData: true,
                        boundingBox: {
                           westLongitude: -166.0,
                           eastLongitude: -74.0,
                           southLatitude: 24.0,
                           northLatitude: 71.0
                        }
                     }
                  ]
               ],
               pointOfContact: [
                  {
                     role: 'pointOfContact',
                     party: [
                        {
                           contactId: 'CID001'
                        }
                     ]
                  }
               ],
               keyword: [
                  {
                     keyword: [
                        {
                           keyword: 'biota',
                           keywordId: 'ISO004'
                        },
                        {
                           keyword: 'farming'
                        }
                     ],
                     'keywordType': 'isoTopicCategory',
                     'thesaurus': {
                        'title': 'ISO 19115 Topic Category',
                        date: [
                           {
                              'date': '2017-11-22',
                              'dateType': 'publication'
                           }
                        ]
                     }
                  }
               ],
               constraint: [
                  {
                     type: 'legal',
                     legal: {
                        'accessConstraint': ['access constraint'],
                        'useConstraint': ['use constraint'],
                        'otherConstraint': ['other constraint']
                     }
                  }
               ],
               defaultResourceLocale: {
                  language: 'eng',
                  country: 'USA',
                  characterSet: 'UTF-8'
               },
               resourceMaintenance: [
                  {
                     frequency: 'resource maintenance frequency'
                  }
               ]
            }
         },
         metadataRepository: [],
         dataDictionary: []
      }
   end


   # additional documentation ----------------
   def additionalDocumentation
      {
         resourceType: [
            {
               type: 'resource type',
               name: 'resource name'
            }
         ],
         citation: [
            {
               title: 'additional documentation citation title'
            }
         ]
      }
   end


   # associated resource ---------------------
   def associatedResource
      {
         resourceType: [
            {
               type: 'resource type',
               name: 'resource name'
            }
         ],
         associationType: 'association type',
         initiativeType: 'initiative type',
         resourceCitation: {
            title: 'citation title',
            date: [
               {
                  'date': '2017-11-22',
                  'dateType': 'publication'
               }
            ],
            responsibleParty: [
               {
                  role: 'originator',
                  party: [
                     {
                        contactId: 'CID003'
                     }
                  ]
               }
            ]
         },
         metadataCitation: {
            title: 'metadata citation tile'
         }
      }
   end


   # contacts --------------------------------
   def address
      {
         addressType: [],
         description: 'address description',
         deliveryPoint: [
            'address line 1',
            'address line 2'
         ],
         city: 'city',
         administrativeArea: 'administrative area',
         postalCode: 'postal code',
         country: 'country'
      }
   end

   def organization_full
      {
         contactId: 'CID006',
         isOrganization: true,
         name: 'organization name six',
         memberOfOrganization: %w(CID004),
         logoGraphic: [
            {
               fileName: 'logo graphic file name one'
            },
            {
               fileName: 'logo graphic file name two'
            }
         ],
         phone: [
            {
               phoneName: 'phone one',
               phoneNumber: '111-111-1111',
               service: ['voice']
            },
            {
               phoneName: 'phone two',
               phoneNumber: '222-222-2222',
               service: ['fax']
            }
         ],
         address: [
            {
               addressType: ['mailing'],
               description: 'address description one',
               deliveryPoint: [
                  'address line 1',
                  'address line 2'
               ],
               city: 'city',
               administrativeArea: 'administrative area',
               postalCode: 'postal code',
               country: 'country'
            },
            {
               addressType: ['physical'],
               description: 'address description two',
               deliveryPoint: [
                  'address line 1',
                  'address line 2'
               ],
               city: 'city',
               administrativeArea: 'administrative area',
               postalCode: 'postal code',
               country: 'country'
            }
         ],
         electronicMailAddress: %w(name1@adiwg.org name2@adiwg.org),
         onlineResource: [
            {
               'uri': 'https://adiwg.mdtranslator/1'
            },
            {
               'uri': 'https://adiwg.mdtranslator/2'
            }
         ],
         hoursOfService: ['hours one', 'hours two'],
         contactInstructions: 'contact instructions',
         contactType: 'contact type'
      }
   end

   def person_full
      {
         contactId: 'CID005',
         isOrganization: false,
         name: 'person name five',
         positionName: 'position name five',
         memberOfOrganization: %w(CID002 CID004),
         logoGraphic: [
            {
               fileName: 'logo graphic file name one'
            },
            {
               fileName: 'logo graphic file name two'
            }
         ],
         phone: [
            {
               phoneName: 'phone one',
               phoneNumber: '111-111-1111',
               service: ['voice']
            },
            {
               phoneName: 'phone two',
               phoneNumber: '222-222-2222',
               service: ['fax']
            }
         ],
         address: [
            {
               addressType: ['mailing'],
               description: 'address description one',
               deliveryPoint: [
                  'address line 1',
                  'address line 2'
               ],
               city: 'city',
               administrativeArea: 'administrative area',
               postalCode: 'postal code',
               country: 'country'
            },
            {
               addressType: ['physical'],
               description: 'address description two',
               deliveryPoint: [
                  'address line 1',
                  'address line 2'
               ],
               city: 'city',
               administrativeArea: 'administrative area',
               postalCode: 'postal code',
               country: 'country'
            }
         ],
         electronicMailAddress: %w(name1@adiwg.org name2@adiwg.org),
         onlineResource: [
         {
            'uri': 'https://adiwg.mdtranslator/1'
         },
         {
            'uri': 'https://adiwg.mdtranslator/2'
         }
      ],
         hoursOfService: ['hours one', 'hours two'],
         contactInstructions: 'contact instructions',
         contactType: 'contact type'
      }
   end

   def phone
      {
         phoneName: 'phone name',
         phoneNumber: '111-111-1111',
         service: ['service one', 'service two']
      }
   end


   # common ----------------------------------
   def citation
      {
         title: 'citation title',
         date: [
            {
               'date': '2017-11-22',
               'dateType': 'publication'
            }
         ],
         responsibleParty: [
            {
               role: 'originator',
               party: [
                  {
                     contactId: 'CID003'
                  }
               ]
            }
         ]
      }
   end

   def citation_full
      {
         title: 'full citation title',
         alternateTitle: [
            'alt title one',
            'alt title two'
         ],
         date: [
            {
               'date': '2017-12-02T13:41:13',
               'dateType': 'publication'
            },
            {
               'date': '2018-04-18',
               'dateType': 'revision'
            }
         ],
         edition: 'edition',
         responsibleParty: [
            {
               role: 'originator',
               roleExtent: [],
               party: [
                  {
                     contactId: 'CID003'
                  },
                  {
                     contactId: 'CID002'
                  }
               ]
            },
            {
               role: 'publisher',
               roleExtent: [],
               party: [
                  {
                     contactId: 'CID001'
                  },
                  {
                     contactId: 'CID002'
                  }
               ]
            },
            {
               role: 'originator',
               roleExtent: [],
               party: [
                  {
                     contactId: 'CID004'
                  },
                  {
                     contactId: 'CID002'
                  }
               ]
            }
         ],
         presentationForm: [
            'form one',
            'form two'
         ],
         identifier: [
            {
               identifier: 'full citation identifier one'
            },
            {
               identifier: 'full citation identifier two',
               namespace: 'ISBN'
            },
            {
               identifier: 'full citation identifier three',
               namespace: 'ISSN'
            }
         ],
         series: series,
         otherCitationDetails: [
            'other detail one',
            'other detail two'
         ],
         onlineResource: [
            {
               'uri': 'https://adiwg.mdtranslator/1'
            },
            {
               'uri': 'https://adiwg.mdtranslator/2'
            }
         ],
         graphic: [
            {
               fileName: 'full citation browse graphic one'
            },
            {
               fileName: 'full citation browse graphic two'
            }
         ]
      }
   end

   def citation_title
      {
         title: 'title only citation'
      }
   end

   def date
      {
         date: nil,
         dateType: nil,
         description: 'date description'
      }
   end

   def identifier
      {
         identifier: 'identifier',
         namespace: 'namespace',
         version: 'version',
         description: 'description',
         authority: citation
      }
   end

   def locale
      {
         language: 'eng',
         characterSet: 'UTF-8',
         country: 'USA'
      }
   end

   def onlineResource
      {
         uri: nil,
         name: 'online resource name',
         protocol: 'protocol',
         description: 'online resource description',
         function: 'online resource function'
      }
   end

   def resourceType
      {
         type: 'resource type',
         name: 'resource type name'
      }
   end

   def scope
      {
         scopeCode: 'scope code',
         scopeDescription: [],
         scopeExtent: []
      }
   end

   def scopeDescription
      {
         dataset: 'dataset',
         attributes: 'attributes',
         features: 'features',
         other: 'other'
      }
   end

   def series
      {
         seriesName: 'series name',
         seriesIssue: 'series issue',
         issuePage: 'issue page'
      }
   end


   # constraint ------------------------------
   def constraint
      {
         type: 'use',
         useLimitation: ['limitation one', 'limitation two'],
         scope: {
            scopeCode: 'scope code'
         },
         graphic: [
            graphic,
            graphic
         ],
         reference: [
            citation_title,
            citation_title
         ],
         releasability: releasability,
         responsibleParty: [
            build_responsibleParty('pointOfContact', ['CID004'])
         ],
         legal: {
            accessConstraint: [
               'access constraint one',
               'access constraint two'
            ]
         },
         security: {
            classification: 'classification'
         }
      }
   end

   def legalConstraint
      {
         type: 'legal',
         useLimitation: [],
         graphic: [],
         reference: [],
         responsibleParty: [],
         legal: {
            accessConstraint: ['access constraint one', 'access constraint two'],
            useConstraint: ['use constraint one', 'use constraint two'],
            otherConstraint: ['other constraint one', 'other constraint two']
         }
      }
   end

   def securityConstraint
      {
         type: 'security',
         useLimitation: [],
         graphic: [],
         reference: [],
         responsibleParty: [],
         security: {
            classification: 'classification',
            userNote: 'user note',
            classificationSystem: 'classification system',
            handlingDescription: 'handling instructions'
         }
      }
   end

   def useConstraint
      {
         type: 'use',
         useLimitation: ['limitation one', 'limitation two'],
         graphic: [],
         reference: [],
         responsibleParty: []
      }
   end

   def releasability
      {
         addressee: [
            build_responsibleParty('addressee', ['CID004'])
         ],
         statement: 'releasability statement',
         disseminationConstraint: ['constraint one', 'constraint two']
      }
   end


   # coverage description --------------------
   def coverageDescription
      {
         coverageName: 'coverage name',
         coverageDescription: 'coverage description',
         processingLevelCode: {
            identifier: 'process level identifier'
         },
         attributeGroup: [],
         imageDescription: {}
      }
   end

   def attributeGroup
      {
         attributeContentType: ['attribute content type one', 'attribute content type two'],
         attribute: []
      }
   end

   def attribute
      {
         sequenceIdentifier: 'sequence identifier name',
         sequenceIdentifierType: 'sequence identifier type',
         attributeDescription: 'attribute description',
         attributeIdentifier: [
            {
               identifier: 'attribute identifier one'
            },
            {
               identifier: 'attribute identifier two'
            }
         ],
         minValue: 0,
         maxValue: 9,
         units: 'min/max units',
         scaleFactor: 99.9,
         offset: 1.0,
         meanValue: 50.0,
         numberOfValues: 9,
         standardDeviation: 9.9,
         bitsPerValue: 9,
         boundMin: 100,
         boundMax: 999,
         boundUnits: 'bound min/max units',
         peakResponse: 99.9,
         toneGradations: 9,
         bandBoundaryDefinition: 'oneOverE',
         nominalSpatialResolution: 99,
         transferFunctionType: 'linear',
         transmittedPolarization: 'leftCircular',
         detectedPolarization: 'rightCircular'
      }
   end

   def imageDescription
      {
         illuminationElevationAngle: 60.0,
         illuminationAzimuthAngle: 40.0,
         imagingCondition: 'image condition code',
         imageQualityCode: {
            identifier: 'image quality identifier'
         },
         cloudCoverPercent: 90,
         compressionQuantity: 9,
         triangulationIndicator: false,
         radiometricCalibrationAvailable: false,
         cameraCalibrationAvailable: false,
         filmDistortionAvailable: false,
         lensDistortionAvailable: false
      }
   end


   # data dictionary -------------------------
   def dataDictionary
      {
         citation: {
            title: 'dictionary title',
            date: [
               {
                  date: '2018-04-05',
                  dateType: 'creation',
                  description: 'dictionary date description'
               }
            ],
            edition: 'version 1.0.0'
         },
         description: 'dictionary description',
         subject: ['subject one', 'subject two'],
         recommendedUse: ['use one', 'use two'],
         locale: [],
         responsibleParty: {
            role: 'dictionary role',
            roleExtent: [],
            party: [
               {
                  contactId: 'CID001'
               }
            ]
         },
         dictionaryFormat: 'deprecated',
         dictionaryFunctionalLanguage: 'dictionary functional language',
         dictionaryIncludedWithResource: false,
         domain: [],
         entity: []
      }
   end

   def dictionaryDomain
      {
         domainId: 'DOM001',
         commonName: 'domain common name',
         codeName: 'domain code name',
         description: 'domain description',
         domainItem: [],
         domainReference: {
            title: 'domain reference title'
         }
      }
   end

   def domainItem
      {
         name: 'domain item name',
         value: 'domain item value',
         definition: 'domain item definition',
         reference: {
            title: 'domain item reference title'
         }
      }
   end

   def entity
      {
         entityId: 'entity ID',
         commonName: 'entity common name',
         codeName: 'entity code name',
         alias: ['alias one', 'alias two'],
         definition: 'entity definition',
         entityReference: [],
         primaryKeyAttributeCodeName: [],
         index: [],
         attribute: [],
         foreignKey: [],
         fieldSeparatorCharacter: 'tab',
         numberOfHeaderLines: 2,
         quoteCharacter: 'double quote'
      }
   end

   def entityAttribute
      {
         commonName: 'attribute common name',
         codeName: 'attribute code name',
         alias: ['alias one', 'alias two'],
         definition: 'attribute definition',
         attributeReference: {},
         dataType: 'data type',
         allowNull: false,
         mustBeUnique: true,
         units: 'units of measure',
         unitsResolution: 1.0,
         isCaseSensitive: false,
         fieldWidth: 1,
         missingValue: '-1',
         domainId: 'DOM001',
         minValue: '100',
         maxValue: '999',
         valueRange: [],
         timePeriod: []
      }
   end

   def foreignKey
      {
         localAttributeCodeName: ['local attribute code name one', 'local attribute code name two'],
         referencedEntityCodeName: 'referenced entity code name',
         referencedAttributeCodeName: ['referenced attribute code name one', 'referenced attribute code name two']
      }
   end

   def index
      {
         codeName: 'index code name',
         allowDuplicates: false,
         attributeCodeName: ['attribute code name one', 'attribute code name two']
      }
   end

   def valueRange
      {
         minRangeValue: '0',
         maxRangeValue: '9'
      }
   end


   # distribution ----------------------------
   def distribution
      {
         description: 'distribution description',
         liabilityStatement: 'distribution liability statement',
         distributor: []
      }
   end

   def distributor
      {
         contact: {},
         orderProcess: [],
         transferOption: []
      }
   end

   def orderProcess
      {
         fees: 'no charge',
         plannedAvailability: '2018-02-05T00:00:00',
         orderingInstructions: 'ordering instructions',
         turnaround: 'one week turnaround'
      }
   end

   def medium
      {
         mediumSpecification: {
            title: 'medium specification'
         },
         density: 99.9,
         units: 'density units',
         numberOfVolumes: 9,
         mediumFormat: [
            'medium format one',
            'medium format two'
         ],
         note: 'medium note',
         identifier: {
            identifier: 'medium identifier'
         }
      }
   end

   def resourceFormat
      {
         formatSpecification: {
            title: 'format specification',
            edition: 'format edition',
            date: [
               date: '2018-02-01',
               dateType: 'revision'
            ],
            identifier: [
               {
                  identifier: 'format identifier'
               }
            ],
            otherCitationDetails: [
               'format information content'
            ]
         },
         amendmentNumber: 'amendment number',
         compressionMethod: 'compression method',
         technicalPrerequisite: 'format technical prerequisite'
      }
   end

   def transferOption
      {
         transferSize: 999,
         unitsOfDistribution: 'MB',
         onlineOption: [],
         offlineOption: [],
         transferFrequency: {
            months: 9
         },
         distributionFormat: []
      }
   end


   # extent ----------------------------------
   def extent
      {
         description: 'description',
         geographicExtent: [],
         verticalExtent: [],
         temporalExtent: []
      }
   end


   # funding ---------------------------------
   def allocation
      {
         sourceAllocationId: 'SAID001',
         amount: 50000.00,
         currency: 'USD',
         sourceId: 'CID004',
         recipientId: 'CID003',
         responsibleParty: [
            build_responsibleParty('funder', %w(CID003 CID004))
         ],
         matching: true,
         comment: 'allocation comment',
         onlineResource: [
            build_onlineResource('http://online.adiwg.org/1')
         ]
      }
   end

   def funding
      {
         allocation: [
            allocation
         ],
         timePeriod: {
            startDateTime: '2018-01-01',
            endDateTime: '2018-12-31'
         },
         description: 'funding description'
      }
   end


   # graphic ---------------------------------
   def graphic
      {
         fileName: 'graphic file name',
         fileDescription: 'graphic description',
         fileType: 'graphic type',
         fileConstraint: [],
         fileUri: []
      }
   end


   # graphic extent --------------------------
   def geographicExtent
      {
         description: 'geographic extent description',
         containsData: true,
         identifier: {
            identifier: 'geographic extent identifier'
         },
         boundingBox: boundingBox,
         geographicElement: []
      }
   end

   def boundingBox
      {
         westLongitude: -170.0,
         eastLongitude: -70.0,
         southLatitude: 40.0,
         northLatitude: 60.0
      }
   end

   def feature
      {
         type: 'Feature',
         id: nil,
         bbox: [],
         geometry: {},
         properties: {}
      }
   end

   def featureCollection
      {
         type: 'FeatureCollection',
         bbox: [],
         features: []
      }
   end

   def geometryCollection
      {
         type: 'GeometryCollection',
         geometries: []
      }
   end

   def lineString
      {
         type: 'LineString',
         coordinates: [
            [100.0, 10.0],
            [101.0, 11.0]
         ]
      }
   end

   def multiLineString
      {
         type: 'MultiLineString',
         coordinates: [
            [
               [100.0, 10.0],
               [101.0, 11.0]
            ],
            [
               [102.0, 12.0],
               [103.0, 13.0]
            ],
         ]
      }
   end

   def multiPoint
      {
         type: 'MultiPoint',
         coordinates: [
            [100.0, 10.0],
            [101.0, 11.0]
         ]
      }
   end

   def multiPolygon
      {
         type: 'MultiPolygon',
         coordinates: [
            [
               [
                  [100.0, 10.0],
                  [101.0, 10.0],
                  [101.0, 11.0],
                  [100.0, 11.0],
                  [100.0, 10.0]
               ]
            ],
            [
               [
                  [110.8, 10.8],
                  [110.8, 10.2],
                  [110.2, 10.2],
                  [110.2, 10.8],
                  [110.8, 10.8]
               ],
               [
                  [120.8, 10.8],
                  [120.8, 10.2],
                  [120.2, 10.2],
                  [120.2, 10.8],
                  [120.8, 10.8]
               ]
            ]
         ]
      }
   end

   def point
      {
         type: 'Point',
         coordinates: [100.0, 10.0]
      }
   end

   def polygon
      {
         type: 'Polygon',
         coordinates: [
            [
               [100.0, 10.0],
               [101.0, 10.0],
               [101.0, 11.0],
               [100.0, 11.0],
               [100.0, 10.0]
            ],
            [
               [110.8, 10.8],
               [110.8, 10.2],
               [110.2, 10.2],
               [110.2, 10.8],
               [110.8, 10.8]
            ],
            [
               [120.8, 10.8],
               [120.8, 10.2],
               [120.2, 10.2],
               [120.2, 10.8],
               [120.8, 10.8]
            ]
         ]
      }
   end

   def properties
      {
         description: 'description',
         featureName: ['feature name one', 'feature name two'],
         identifier: [
            {
               identifier: 'geoJson properties identifier'
            }
         ],
         featureScope: 'feature scope',
         acquisitionMethod: 'acquisition method'
      }
   end


   # keyword --------------------------------
   def keyword
      {
         keyword: 'keyword',
         keywordId: 'keyword id'
      }
   end

   def keywords
      {
         keyword: [],
         keywordType: 'theme',
         thesaurus: {
            title: 'thesaurus title',
            date: [
               {
                  'date': '2017-11-22',
                  'dateType': 'publication'
               }
            ]
         }
      }
   end


   # lineage --------------------------------
   def lineage
      {
         statement: 'statement',
         scope: scope,
         citation: [citation],
         processStep: [],
         source: []
      }
   end

   def processStep
      {
         stepId: 'PS001',
         description: 'description',
         rationale: 'rationale',
         processor: [],
         stepSource: [],
         stepProduct: [],
         reference: []
      }
   end

   def source
      {
         sourceId: 'SRC001',
         description: 'description',
         sourceCitation: citation_title,
         metadataCitation: [],
         spatialResolution: {scaleFactor: 9999},
         referenceSystem: spatialReferenceSystem,
         sourceProcessStep: [],
         scope: scope
      }
   end


   # maintenance ----------------------------
   def maintenance
      {
         frequency: 'maintenance frequency',
         date: [],
         scope: [],
         note: ['note one', 'note two'],
         contact: []
      }
   end


   # metadata -------------------------------
   def metadata
      {
         metadataInfo: {},
         resourceInfo: {},
         resourceLineage: [],
         resourceDistribution: [],
         associatedResource: [],
         additionalDocumentation: [],
         funding: []
      }
   end

   def metadataInfo
      {
         metadataIdentifier: {},
         parentMetadata: {},
         defaultMetadataLocale: {},
         otherMetadataLocale: [],
         metadataContact: [],
         metadataDate: [],
         metadataOnlineResource: [],
         metadataConstraint: [],
         alternateMetadataReference: [],
         metadataStatus: 'metadata status',
         metadataMaintenance: {}
      }
   end

   def resourceInfo
      {
         resourceType: [],
         citation: {},
         abstract: 'abstract',
         shortAbstract: 'short abstract',
         purpose: 'purpose',
         credit: ['credit one', 'credit two'],
         timePeriod: {},
         status: ['status one', 'status two'],
         pointOfContact: [],
         spatialReferenceSystem: [],
         spatialRepresentationType: ['space reference type one', 'space reference type two'],
         spatialRepresentation: [],
         spatialResolution: [],
         temporalResolution: [],
         extent: [],
         coverageDescription: [],
         taxonomy: [],
         graphicOverview: [],
         resourceFormat: [],
         keyword: [],
         resourceUsage: [],
         constraint: [],
         defaultResourceLocale: locale,
         otherResourceLocale: [],
         resourceMaintenance: [],
         environmentDescription: 'environment description',
         supplementalInfo: 'supplemental information'
      }
   end

   def schema
      {
         name: 'mdJson',
         version: '2.4.0'
      }
   end


   # metadata repository --------------------
   def metadataRepository
      {
         repository: 'metadata repository',
         metadataStandard: 'metadata standard',
         citation: citation
      }
   end


   # resource specific usage ----------------
   def resourceUsage
      {
         specificUsage: 'specific usage',
         temporalExtent: [],
         userDeterminedLimitation: 'user determined limitation',
         limitationResponse: ['response one', 'response two'],
         documentedIssue: citation_title,
         additionalDocumentation: [ citation_title ],
         userContactInfo: []
      }
   end


   # responsibility -------------------------
   def responsibleParty
      {
         role: 'party role',
         roleExtent: [],
         party: []
      }
   end

   def party
      {
         contactId: nil,
         organizationMembers: []
      }
   end


   # spatial reference ----------------------
   def geodetic
      {
         datumIdentifier: {identifier: 'datum name'},
         ellipsoidIdentifier: {identifier: 'ellipsoid name'},
         semiMajorAxis: 9999.9,
         axisUnits: 'axis units',
         denominatorOfFlatteningRatio: 999.9
      }
   end

   def obliqueLinePoint
      {
         obliqueLineLatitude: 11.1,
         obliqueLineLongitude: 22.2
      }
   end

   def projection
      {
         projectionIdentifier: { identifier: 'projection identifier', name: 'projection name' },
         gridSystemIdentifier: { identifier: 'grid system identifier', name: 'grid system name' },
         gridZone: 'zone 4',
         standardParallel1: 9.9,
         standardParallel2: 9.9,
         longitudeOfCentralMeridian: 9.9,
         latitudeOfProjectionOrigin: 9.9,
         falseEasting: 9.9,
         falseNorthing: 9.9,
         falseEastingNorthingUnits: 'false units',
         scaleFactorAtEquator: 9.9,
         heightOfProspectivePointAboveSurface: 9.9,
         longitudeOfProjectionCenter: 9.9,
         latitudeOfProjectionCenter: 9.9,
         scaleFactorAtCenterLine: 9.9,
         scaleFactorAtCentralMeridian: 9.9,
         straightVerticalLongitudeFromPole: 9.9,
         scaleFactorAtProjectionOrigin: 9.9,
         azimuthAngle: 9.9,
         azimuthMeasurePointLongitude: 9.9,
         obliqueLinePoint: [obliqueLinePoint, obliqueLinePoint],
         landsatNumber: 9,
         landsatPath: 9,
         local: local
      }
   end
 
   def referenceSystemParameterSet
      {
         projection: {},
         geodetic: {},
         verticalDatum: {}
      }
   end

   def spatialReferenceSystem
      {
         referenceSystemType: 'spatial reference system type',
         referenceSystemIdentifier: {},
         referenceSystemWKT: 'WKT',
         referenceSystemParameterSet: {}
      }
   end

   def verticalDatum
      {
         datumIdentifier: { identifier: 'vertical datum identifier' },
         encodingMethod: 'encoding method',
         isDepthSystem: false,
         verticalResolution: 9.99,
         unitOfMeasure: 'unit of measure'
      }
   end

   def local
      {
         description: 'local description',
         georeference: 'local georeference',
         fixedToEarth: false
      }
   end


   # spatial representation -----------------
   def dimension
      {
         dimensionType: 'dimension type',
         dimensionSize: 9,
         resolution: measure,
         dimensionTitle: 'dimension title',
         dimensionDescription: 'dimension description'
      }
   end

   def georectified
      {
         gridRepresentation: gridRepresentation,
         checkPointAvailable: false,
         checkPointDescription: 'check point description',
         cornerPoints: [
            [100.0, 50.0],
            [25.0, 25.0]
         ],
         centerPoint: [62.0, 37.0],
         pointInPixel: 'upperRight',
         transformationDimensionDescription: 'transformation dimension description',
         transformationDimensionMapping: 'transformation dimension mapping'
      }
   end

   def georeferenceable
      {
         gridRepresentation: gridRepresentation,
         controlPointAvailable: false,
         orientationParameterAvailable: false,
         orientationParameterDescription: 'orientation parameter description',
         georeferencedParameter: 'georeferenced parameter',
         parameterCitation: [
            {
               title: 'parameter citation title one'
            },
            {
               title: 'parameter citation title two'
            },
         ]
      }
   end

   def gridRepresentation
      {
         numberOfDimensions: 9,
         dimension: [],
         cellGeometry: 'point',
         transformationParameterAvailable: false
      }
   end

   def vectorObject
      {
         objectType: 'object type code',
         objectCount: 9
      }
   end

   def vectorRepresentation
      {
         topologyLevel: 'topology level',
         vectorObject: []
      }
   end


   # spatial resolution ----------------------
   def bearingDistanceResolution
      {
         distanceResolution: 99.9,
         distanceUnitOfMeasure: 'distance unit',
         bearingResolution: 9.9,
         bearingUnitOfMeasure: 'bearing unit',
         bearingReferenceDirection: 'north',
         bearingReferenceMeridian: 'magnetic'
      }
   end

   def coordinateResolution
      {
         abscissaResolutionX: 999.9,
         ordinateResolutionY: 99.9,
         unitOfMeasure: 'units'
      }
   end

   def geographicResolution
      {
         latitudeResolution: 99.9,
         longitudeResolution: 9.9,
         unitOfMeasure: 'unit'
      }
   end

   def measure
      {
         type: 'distance',
         value: 99,
         unitOfMeasure: 'distance uom'
      }
   end


   # taxonomy -------------------------------
   def taxonomy
      {
         taxonomicSystem: [taxonSystem],
         generalScope: 'general scope',
         identificationReference: [identifier],
         observer: [build_responsibleParty('observer', ['CID003'])],
         identificationProcedure: 'procedures',
         identificationCompleteness: 'completeness',
         voucher: [build_taxonVoucher],
         taxonomicClassification: [taxonClass]
      }
   end

   def taxonClass
      {
         taxonomicSystemId: 'taxon id',
         taxonomicLevel: 'taxon rank',
         taxonomicName: 'taxon name',
         commonName: ['common one', 'common two'],
         subClassification: []
      }
   end

   def taxonSystem
      {
         citation: citation,
         modifications: 'modifications'
      }
   end

   def taxonVoucher
      {
         specimen: 'specimen',
         repository: build_responsibleParty('curator', ['CID004'])
      }
   end


   # temporal extent ------------------------
   def duration
      {
         years: 1,
         months: 2,
         days: 3,
         hours: 4,
         minutes: 5,
         seconds: 6
      }
   end

   def timeInterval
      {
         interval: 1.1,
         units: 'year'
      }
   end

   def timeInstant
      {
         id: 'TIID001',
         description: 'description',
         identifier: {
            identifier: 'time instant identifier'
         },
         instantName: ['instant name one', 'instant name two'],
         dateTime: '2016-10-24T10:25:00'
      }
   end

   def timePeriod
      {
         id: 'TPID001',
         description: 'description',
         identifier: {
            identifier: 'time period identifier'
         },
         periodName: ['period name one', 'period name two'],
         startDateTime: '2016-10-14T11:10:15.2-10:00',
         endDateTime: '2016-12-31',
         startGeologicAge: {},
         endGeologicAge: {},
         timeInterval: timeInterval,
         duration: duration
      }
   end

   def geologicAge
      {
         ageTimeScale: 'geologic age time scale',
         ageEstimate: 'geologic age estimate',
         ageUncertainty: 'geologic age uncertainty',
         ageExplanation: 'geologic age explanation',
         ageReference: []
      }
   end


   # vertical extent ------------------------
   def verticalExtent
      {
         description: 'description',
         minValue: 0,
         maxValue: 999,
         crsId:
            {
               referenceSystemType: 'reference system type',
               referenceSystemIdentifier: {
                  identifier: 'reference system identifier'
               }
            }
      }
   end

end
