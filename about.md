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

The *Alaska Data Integration Working Group* (ADIwg)[^1] was formed to examine and address the technical barriers to
efficiently integrate and share data within and among participating organizations. One of ADIwg's primary objectives is implementing a standard methodology for exchanging metadata among its member organizations. Due to the importance of data integration with our international partners, ADIwg adopted the ISO 19115-2/19110 standard as its metadata standard. 

Implementation of the 19115 family of ISO standards is a substantial undertaking that can present a steep learning curve. In addition, the complexity and verbosity of the ISO standards makes generating, transmitting, and parsing expensive. This also slows adoption and tends to limit implementation to a smaller subset of ISO metadata features. Further, the ADIwg organizations and their partners vary widely in size and technical capabilities, from small NGO research groups to state offices, universities, and large federal agencies. ADIwg’s search for existing ISO metadata tools was unable to locate a solution that would accommodate the diverse technical requirements of membership or support the large subset of the ISO standard adopted by ADIwg.

For these reasons, ADIwg chose to develop a collection of tools to assist in the creation and management of ISO-compliant metadata. The first step was to simplify the standard itself by creating an ISO-compatible JSON standard (which could also serve as a lightweight alternative for sharing metadata). To support the JSON standard ADIwg is developing the mdTranslator, a software 'engine' that converts metadata in the ADiwg JSON structure to other metadata formats, including ISO 19115-2.

## What it does

<figure>
	<a href="{{ site.url}}/images/translator_process.png"><img src="{{ site.url}}/images/translator_process.png"></a>
	<figcaption>Overview of the translator process.</figcaption>
</figure>

## How it works

<figure>
	<a href="{{ site.url}}/images/translator_arch.png"><img src="{{ site.url}}/images/translator_arch.png"></a>
	<figcaption>The mdTranslator architecture.</figcaption>
</figure>

[^1]: Pronounced *add-ee-wig*

[projects]: {{ site.url }}/projects