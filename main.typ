#import "psu_thesis.typ": *

#show: psu_thesis.with(
  title: "Dissertation Title",
  author: "Your Name",
  department: "Your Department",
  degree_type: "doctorate", // one of "doctorate" or "masters"
  committee_members: (
    (
        name: "Committee Member 1",
        title: "Committee Member Title",
    )
  ),
  date: ( // Date of degree CONFERRAL
    year: "2023",
    month: "December",
    day: "15",
  )
)

// Here you can include chapters (or anything) written in seperate files. One is given as an example
#include "ch1.typ"

#bibliography("citations.bib", style: "ieee")

#pagebreak()

#show: appendices

#heading("Appendix Title", supplement: "Appendix") <app_a>
