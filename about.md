---
layout: page
permalink: /about/index.html
title: About the Project
tagline: Making metadata manageable.
tags: [about, ADIwg, metadata, mdTranslator]
modified: 02-14-2014
image:
  feature: header1024-1.png
  credit:
  creditlink:
---

<section id="table-of-contents" class="toc">
  <header>
    <h3>Contents</h3>
  </header>
<div id="drawer" markdown="1">
*  Auto generated table of contents
{:toc}
</div>
</section><!-- /#table-of-contents -->

## Why

The [*Alaska Data Integration Working Group*](http://www.adiwg.org) (ADIwg)[^1] was formed to examine and address the technical barriers to
efficiently integrate and share data within and among participating organizations. One of ADIwg's primary objectives is implementing a standard methodology for exchanging metadata among its member organizations. Due to the importance of data integration with our international partners, ADIwg adopted the ISO 19115-2/19110 standard[^2] as its metadata standard.

Implementation of the 19115 family of ISO standards is a substantial undertaking that can present a steep learning curve. In addition, the complexity and verbosity of the ISO standards makes generating, transmitting, and parsing expensive. This also slows adoption and tends to limit implementation to a smaller subset of ISO metadata features. Further, the ADIwg organizations and their partners vary widely in size and technical capabilities, from small NGO research groups to state offices, universities, and large federal agencies. ADIwg’s search for existing ISO metadata tools was unable to locate a solution that would accommodate the diverse technical requirements of membership or support the large subset of the ISO standard adopted by ADIwg.

For these reasons, ADIwg chose to develop a collection of tools to assist in the creation and management of ISO-compliant metadata. The first step was to simplify the standard itself by creating an ISO-compatible JSON standard (which could also serve as a lightweight alternative for sharing metadata). To support the JSON standard ADIwg is developing the mdTranslator, a software 'engine' that converts metadata in the ADiwg JSON structure to other metadata formats, including ISO 19115-2.

## What it does

The mdTranslator's primary purpose is to transform metadata stored in the ADIwg JSON standard into other well-known file formats. The original translation target was ISO 19115-2 XML. However, the architecture of the translator allows for possible conversion between many other formats. The basic process is illustrated in the figure below:

<figure>
    <a href="{{ site.url}}/images/translator_process.png"><img src="{{ site.url}}/images/translator_process.png"></a>
    <figcaption>Overview of the translator process.</figcaption>
</figure>

The mdTranslator isolates metadata creators from the complexity, rigor, formatting, and terminology of the output standard - a significant benefit when the output is based on the ISO 19139 XML Schema.

## How it works

The mdTranslator is written using the [Ruby](https://www.ruby-lang.org/en/) language and is available as a Ruby gem or from the GitHub [repository](https://github.com/adiwg/mdTranslator). A [JSON-schema](http://json-schema.org/) is available to validate ADIwg JSON. The schema files are available as a gem or on [GitHub](https://github.com/adiwg/adiwg-json-schemas). See the [ADIwg GitHub] site for more detail and usage instructions on each component, including documentation for both [project](https://github.com/adiwg/project-metadata-iso) and [data](https://github.com/adiwg/data-metadata) metadata standards.

The mdTranslator's loosely coupled architecture allows components to be developed independently. "Readers" convert formatted data to the internal standard, which is read by "writers" and translated into the target format. This architecture extends the benefits beyond ADIwg, e.g. an ISO reader could be used with any writer for translation. In this sense, the mdTranslator architecture can serve as a scaffold for building additional metadata converters.

<figure>
    <a href="{{ site.url}}/images/translator_arch.png"><img src="{{ site.url}}/images/translator_arch.png"></a>
    <figcaption>The mdTranslator architecture.</figcaption>
</figure>

1. Input is passed to the mdTranslator in one of two ways, an HTTP POST via the optional *Ruby on Rails* webservice or the default command line interface.
2. The input(ADIwg JSON in this example) is validated. The validation process checks for *syntax* errors only. In the case of ADIwg JSON, the input is validated against the ADIwg JSON schema. The JSON schema defines document structure, data types, and required elements.
3. Following successful validation, the input is read and transformed into the *internal standard* by the appropriate *reader*. Each input format has an associated reader. The internal standard facilitates communication between readers and writers. It also allows the mdTranslator components to be developed independently.
4. Next, the *writer* that corresponds to the desired output format accesses the internal standard to produce the desired output. The architecture allows any writer to be paired with any reader.
5. Finally, the the translated metadata is returned.
6. When available, translation may be performed using a [XSLT](en.wikipedia.org/wiki/XSLT) (Extensible Stylesheet Language Transformation). This may make development of writers for some formats unneccesary.
7. Readers may be developed for any format that can be accessed in Ruby.

<hr/>
[^1]: Pronounced *add-ee-wig*
[^2]: The intent is to support successive ISO standards as they are released, starting with 19115-1 in 2014.

[ADIwg GitHub]: https://github.com/adiwg