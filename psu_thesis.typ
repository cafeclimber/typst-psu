#let appendix(title) = {
  heading(title, supplement: "Appendix")
}

#let appendices(body) = {
  counter(heading).update(0)
  counter("appendices").update(1)

  set heading(
    numbering: (..nums) => {
      let vals = nums.pos()
      let value = "ABCDEFGHIJ".at(vals.at(0) - 1)
      if vals.len() == 1 {
        return value + ": "
      }
      else {
        return value + "." + nums.pos().slice(1).map(str).join(".")
      }
    }
  );
  
  body
}

#let psu_thesis(
    title: "Title",
    author: (),
    committee_members: (),
    paper-size: "us-letter",
    bibliography-file: none,
    department: "Department",
    degree_type: "doctorate",
    date: (
        year: "2000",
        month: "January",
        day: "01"
    ),

    body
) = {
  // Useful variables
  let doc_title = if degree_type == "doctorate" [dissertation] else [thesis]
  let doc_title_cap = if degree_type == "doctorate" [Dissertation] else [Thesis]
  let psu = "The Pennsylvania State University"
  let degree = {
      if degree_type == "doctorate" [Doctor of Philosophy]
      else [Master of Science]
  }
  let unit = "The Graduate School"
  let front_matter_sections = (
    [Abstract],
    [Table of Contents],
    [List of Figures],
    [List of Tables],
    [List of Maps],
    [List of Abbreviations],
    [Preface],
    [Acknowledgements],
    [Epigraph],
    [Frontispiece],
    [Dedication],
  )

  set document(title: title, author: author)
  set page(
      paper: paper-size,
      margin: 1in,
  )
  set text(font: "HK Grotesk", size: 12pt)
  show heading.where(level: 1): it => {
    set text(18pt)
    if it.supplement != auto [
      #it.supplement 
      #counter(heading).display() | 
      #it.body
    ] else [
      #it.body
    ]
    v(0.5em)
  }

  // Title page
  {
    set page (numbering: none)
    set par(leading: 2em)
    set align(center)

    v(10mm)
    [#psu \ #unit]
    v(20mm)
    text(14pt, weight: "bold", upper(title))
    v(20mm)
    [A #doc_title_cap in \ #department \ by \ #author]
    v(10mm)
    [#sym.copyright #date.year #author]
    v(10mm)
    par(leading: 0.65em, [
        Submitted in Partial Fulfilment \
        of the Requirements \
        for the Degree of
        #v(10mm)
        #degree
    ])
    v(10mm)
    [#date.month #date.year]
  }
  pagebreak(weak: true)

  // Front matter
  {
    set page(numbering: "i")
    
    // Committee Page
    "The " + doc_title + " of " + author + " was reviewed and approved by the following:\n"
    v(10mm)
    for member in committee_members {
        member.name + "\n"
        member.title
        v(12pt)
    }
    pagebreak(weak: true)
    
    heading(outlined: false)[Abstract]
    pagebreak(weak: true)

    heading(outlined: false)[Table of Contents]
    locate(loc => {
      let items = query(heading, loc)
      let fm = items.filter(it => it.body in front_matter_sections and it.outlined)
      for line in fm {
        line.body
        box(width: 1fr, repeat[.])
        numbering("i", line.location().position().page)
        [\ ]
      }
    })
    v(1em)
    locate(loc => {
      let items = query(heading, loc)
      let lines = items.filter(it => it.level == 1 and it.body not in front_matter_sections)
      for line in lines {
        let string = [
          #if line.supplement != auto [
            #line.supplement 
            #counter(heading).at(line.location()).first() | 
          ]
          #line.body
          #box(width: 1fr, repeat[.])
          #counter(page).at(line.location()).first()
          \ 
        ] 
        if line.has("label") {
          link(line.label, string)
        } else {
          string
        }
        let its = query(heading, after: line.location()).slice(1)
        let children = ()
        for h in its {
          if h.level == 1 { break }
          let string = [
            #(" " * 4 * h.level)
            #h.body 
            #box(width: 1fr, repeat[.])
            #counter(page).at(h.location()).first()\ 
          ]
          if h.has("label") {
            link(h.label, string)
          } else {
            string
          }
        }
        v(1em)
      }
    })
    pagebreak(weak: true)
    
    // We have to add headings to these lists to include them in the overall ToC
    heading[List of Figures]
    outline(title: none, target: figure.where(kind: image))
    pagebreak(weak: true)
    
    heading[List of Tables]
    outline(title: none, target: figure.where(kind: table))
    pagebreak(weak: true)
    
    heading[Acknowledgements]
    pagebreak(weak: true)
    
    heading[Dedication]
    pagebreak(weak: true)
  }

  set page(numbering: "1")
  set heading(numbering: "1.1")
  counter(page).update(1)

  body
}
