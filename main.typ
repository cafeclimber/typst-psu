#import "psu_thesis.typ": *

#show: psu_thesis.with(
  title: "Distributed Hybrid Beamforming Techniques for Random Three-Dimensional Arrays",
  author: "Bailey Campbell",
  department: "Electrical Engineering",
  degree_type: "doctorate",
  committee_members: (
    (
        name: "Gregory H. Huff",
        title: "Associate Professor of Electrical Engineering\nDissertation Adviser\nChair of Committee",
    ),
    (
        name: "Timothy Kane",
        title: "Professor of Electrical Engineering",
    ),
  ),
  date: (
    year: "2023",
    month: "December",
    day: "15",
  )
)

#include "ch1.typ"

#bibliography("citations.bib", style: "ieee")

#pagebreak()

#show: appendices

#heading("Appendix Title", supplement: "Appendix") <app_a>
