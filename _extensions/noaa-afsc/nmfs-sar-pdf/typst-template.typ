/*
This is a Typst template file for a NOAA Fisheries Stock Assessment Reports (SAR) for marine mammals.
*/

// Function to set up the document's style.
#let article(
  // Document metadata
  title: none,
  subtitle: none,
  authors: none,
  affiliations: none,
  date: none,
  publication-date: none,
  
  // Custom NMFS SAR variables
  nmfs-region: none,
  common-name: none,
  genus-species: none,
  stock-name: none,
  sar-year: none,

  // Layout and page settings
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  
  // Language and typography
  lang: "en",
  region: "US",
  font: "STIX Two Text",
  fontsize: 11pt,
  title-size: 1.75em,
  subtitle-size: 1.25em,
  line-spacing: 0.8,
  linenumbering: false,

  // Heading styles
  heading-family: "Roboto",
  heading-weight: "semibold",
  heading-style: "normal",
  heading-color: rgb("#00559B"),
  heading-line-height: 0.65em,
  sectionnumbering: none,
  
  // Table of contents
  toc: false,
  toc_title: "Table of Contents",
  toc_depth: 3,
  toc_indent: 1.5em,

  // The document's body content.
  body
) = {
  // Set the document's basic properties.
  set document(
    title: title
  )

  // Construct the running title for the header
  let runningtitle = "Marine Mammal Stock Assessment Report - " + nmfs-region + " " + sar-year + linebreak() + common-name + " (" + emph[#genus-species] + ")" + if stock-name != none {" - " + stock-name} else {""}

  // Set the page properties, including header, footer, and background
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
    footer: context [
      #set text(size: 8pt, font: "Roboto", fill: rgb("#5EB6D9"))
      #h(1fr)
      Page #counter(page).display("1 of 1", both: true)
    ],
    header: align(right + horizon)[
      #set text(size: 9pt, font: "Roboto", fill: rgb("#5EB6D9"))
      #set par(leading: 0.6em)
      #runningtitle
    ],
    background: context { 
      if(counter(page).get().at(0) == 1) {
        align(left + top)[
          #image("/assets/22Fisheries SEA_T1 CornerTall.png", width: 20%)
        ]
      }
    } 
  )

  // Set the text properties.
  set text(
    font: font,
    size: fontsize,
    lang: lang,
    fill: rgb("#323C46")
  )

  // Set base paragraph properties.
  set par(
    justify: true,
    leading: line-spacing * 1em,
  )

  // Set heading properties.
  if sectionnumbering != none {
    set heading(numbering: sectionnumbering)
  }

  // Set list properties.
  set list(
    indent: 2em,
    body-indent: 2em,
  )

  // Set enum properties.
  set enum(
    indent: 2em,
    body-indent: 2em,
  )

  // Title page layout
  if title != none {
    align(left)[#block(inset: (left: 2em, right: 2em, top: 2em, bottom: 1em))[
      #set par(leading: heading-line-height)
      #set text(font: heading-family, weight: heading-weight, style: heading-style, fill: heading-color)
      #text(size: title-size)[#title]
      #if subtitle != none {
        parbreak()
        text(size: subtitle-size)[#subtitle]
      }
    ]]
    v(1em)
    line(length: 100%, stroke: 0.5pt + gray)
    v(1em)
  }
  
  // Authors and Affiliations
  if authors != none {
    box(inset: (left: 2em, right: 2em), {
      set text(font: "Roboto")
      authors.map(author => {
        text(11pt, weight: "semibold", author.name)
        h(1pt)
        if "affiliation" in author {
          let matching_affils = if affiliations != none and "affiliation" in author {
            let affiliations_list = if type(affiliations) == dictionary { (affiliations,) } else { affiliations }
            affiliations_list.filter(affil => author.affiliation.contains(affil.id))
          } else { () }
          if matching_affils.len() > 0 {
            super(matching_affils.map(affil => affil.id).join(","))
          }
        }
      }).join(", ", last: " and ")
    })
    parbreak()
  }

  if affiliations != none {
    box(inset: (left: 2em, right: 2em, bottom: 10pt), {
      set text(font: "Roboto", size: 9pt);
      let affiliations_list = if type(affiliations) == dictionary { (affiliations,) } else { affiliations }
      affiliations_list.map(affil => {
        super(affil.id)
        h(1pt)
        // Build an array of location parts and join them.
        let location_parts = ()
        if "city" in affil {
          location_parts.push(affil.city)
        }
        if "region" in affil {
          location_parts.push(affil.region)
        }
        if "country" in affil {
          location_parts.push(affil.country)
        }
        let location = location_parts.join(", ")
        
        affil.name + linebreak() + h(3pt) + affil.department + (if location != "" {linebreak() + h(3pt) + location} else {""})
      }).join("\n")
    })
  }

  // Corresponding author
  if authors != none {
    let corresponding_authors_list = authors.filter(author => "attributes" in author and "corresponding" in author.attributes and author.attributes.corresponding)
    if corresponding_authors_list.len() > 0 {
      let corresponding_author = corresponding_authors_list.first()
      v(1em)
      box(inset: (left: 2em, right: 2em), {
        set text(font: "Roboto", style: "italic", size: 9pt)
        "Corresponding author: "
        corresponding_author.name
        if "email" in corresponding_author {
          " (" + corresponding_author.email + ")"
        }
      })
    }
  }

  v(1em)
  line(length: 100%, stroke: 0.5pt + gray)
  v(1em)

  // Reproducibility and date statement
  let pub_date_str = if publication-date != none {
    let parts = publication-date.split("-")
    datetime(
      year: int(parts.at(0)),
      month: int(parts.at(1)),
      day: int(parts.at(2))
    ).display("[month repr:long] [day], [year]")
  } else {
    "not specified"
  }

  place(bottom)[
    #box(inset: (left: 2em, right: 2em))[
      #set text(font: "Roboto", size: 9pt)
      This document was produced from a reproducible workflow.
      This version was rendered on #date.
      This marine mammal stock assessment report was published on #pub_date_str.
    ]
  ]
  
  // Table of Contents
  if toc {
    pagebreak()
    outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent,
    )
  }

  // Add a page break after the title page content.
  pagebreak()

  // The main content of the document.
  body
}
