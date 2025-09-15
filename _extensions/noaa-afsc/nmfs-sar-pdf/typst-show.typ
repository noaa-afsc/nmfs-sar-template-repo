// ==============================================================================
// TYPST RENDERER
// ==============================================================================
// This file is the entry point for the Quarto extension. It calls the main
// `article` function defined in `typst-template.typ` and passes it all the
// necessary metadata from the Quarto YAML front matter.
//

#show: doc => article(
  // --- DOCUMENT METADATA FROM QUARTO YAML ---
  // The variables below are automatically populated by Quarto's Pandoc
  // processing and are passed to our custom `article` function.
  // Each `$if(variable)$ ... $endif$` block ensures the variable is only
  // passed if it exists in the .qmd YAML.
  
  // Title and Subtitle
  $if(title)$
    title: [$title$],
  $endif$
  $if(subtitle)$
    subtitle: [$subtitle$],
  $endif$
  
  // Author information
  $if(by-author)$
    authors: (
      $for(by-author)$
          ( 
            name: [$it.name.literal$],
            affiliation: (
              $for(it.affiliations)$
                "$it.id$"$sep$,$endfor$
            ),
            $if(it.attributes)$
              attributes: (
                $if(it.attributes.corresponding)$corresponding: $it.attributes.corresponding$,$endif$
                $if(it.attributes.equal-contributor)$equal-contributor: $it.attributes.equal-contributor$,$endif$
              ),
            $endif$
            $if(it.orcid)$
              orcid: "https://orcid.org/$it.orcid$",
            $endif$
            $if(it.email)$
              email: [$it.email$],
            $endif$
          )$sep$,$endfor$
    ),
  $endif$
  
  // Affiliation details
  $if(affiliations)$
    affiliations: (
      $for(affiliations)$
      (
        id: "$it.id$",
        name: "$it.name$",
        $if(it.department)$
        department: "$it.department$",
        $endif$
        $if(it.city)$
        city: "$it.city$",
        $endif$
        $if(it.region)$
        region: "$it.region$",
        $endif$
        $if(it.country)$
        country: "$it.country$",
        $endif$
      )
      $sep$,$endfor$
    ),
  $endif$

  // --- CUSTOM NMFS SAR TEMPLATE VARIABLES ---
  // These variables were added to the top-level YAML in `template.qmd`.
  $if(nmfs-region)$
    nmfs-region: "$nmfs-region$",
  $endif$
  $if(common-name)$
    common-name: "$common-name$",
  $endif$
  $if(genus-species)$
    genus-species: "$genus-species$",
  $endif$
  $if(stock-name)$
    stock-name: "$stock-name$",
  $endif$
  $if(sar-year)$
    sar-year: "$sar-year$",
  $endif$

  // Document Date, Language, and Region
  $if(date)$
    date: "$date$",
  $endif$
  $if(publication-date)$
    publication-date: "$publication-date$",
  $endif$
  $if(lang)$
    lang: "$lang$",
  $endif$
  $if(region)$
    region: "$region$",
  $endif$
  
  // Layout and Fonts
  $if(margin)$
    margin: ($for(margin/pairs)$$margin.key$: $margin.value$$sep$,$endfor$),
  $endif$
  $if(papersize)$
    paper: "$papersize$",
  $endif$
  $if(mainfont)$
    font: ("$mainfont$",),
  $elseif(brand.typography.base.family)$
    font: ("$brand.typography.base.family$",),
  $endif$
  $if(fontsize)$
    fontsize: $fontsize$,
  $elseif(brand.typography.base.size)$
    fontsize: $brand.typography.base.size$,
  $endif$
  $if(linenumbering)$
    linenumbering: $linenumbering$,
  $endif$
  
  // Headings
  $if(title)$
    $if(brand.typography.headings.family)$
      heading-family: ("$brand.typography.headings.family$",),
    $endif$
    $if(brand.typography.headings.weight)$
      heading-weight: $brand.typography.headings.weight$,
    $endif$
    $if(brand.typography.headings.style)$
      heading-style: "$brand.typography.headings.style$",
    $endif$
    $if(brand.typography.headings.decoration)$
      heading-decoration: "$brand.typography.headings.decoration$",
    $endif$
    $if(brand.typography.headings.color)$
      heading-color: $brand.typography.headings.color$,
    $endif$
    $if(brand.typography.headings.line-height)$
      heading-line-height: $brand.typography.headings.line-height$,
    $endif$
  $endif$
  
  // Section Numbering and TOC
  $if(section-numbering)$
    sectionnumbering: "$section-numbering$",
  $endif$
  $if(toc)$
    toc: $toc$,
  $endif$
  $if(toc-title)$
    toc_title: [$toc-title$],
  $endif$
  $if(toc-indent)$
    toc_indent: $toc-indent$,
  $endif$
  toc_depth: $toc-depth$,
  
  // Columns
  cols: $if(columns)$$columns$$else$1$endif$,
  
  // Pass the main document body
  doc,
)

// ==============================================================================
// CUSTOM SHOW RULES
// ==============================================================================
// These rules are applied to specific elements after the main article function
// has been processed. They provide fine-grained control over the appearance of
// math equations, headings, figures, etc.

#show math.equation: set text(font: "STIX Two Math")

// This `show` rule styles all headings.
#show heading: it => block(width: 100%)[
  #set text(weight: "regular", 
            font: "Roboto",
            fill: rgb("#00559B"))
  #(it.body)
]

// This `show` rule adds vertical spacing around figures and disables line numbering.
#show figure: it => {
  set par.line(numbering: none)
  block(width: 100%, inset: (top: 1em, bottom: 1em), it)
}

// This `show` rule styles figure captions.
#show figure.caption: c => context {
  set par(justify: true);
  align(left)[
    #text(fill: luma(130), weight: "bold", size: 10pt)[
      #c.supplement #c.counter.display(c.numbering)
    ]
    #text(fill: luma(130), size: 10pt)[
      #c.separator #c.body
    ]
  ]
}

// This `show` rule specifically styles top-level (level 1) headings.
#show heading.where(
  level: 1
): it => [
  #set align(left)
  #set text(font:"Roboto", 
            weight: "semibold",
            fill: rgb("#00559B"))
  #pad(top: 1.5em, it.body)
]

// This `show` rule specifically styles level 2 headings.
#show heading.where(
  level: 2
): it => [
  #set align(left)
  #set text(font:"Roboto", 
            weight: "semibold",
            fill: rgb("#00559B"))
  #pad(top: 1.2em, it.body)
]

// This `show` rule styles horizontal lines.
#show line: it => {
  v(1.5em, weak: true)
  line(length: 100%)
  v(1.5em, weak: true)
}

// Set internal table properties
#set table(
  stroke: none,
)

// Conditionally apply line numbering.
$if(linenumbering)$
#set par.line(numbering: n => text(fill: gray, size: 8pt, str(n) + " "))
$endif$
