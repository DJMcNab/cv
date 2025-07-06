#let primary_colour = rgb("#3730a3")
#let link_colour = rgb("#12348e")

#let icon(name, shift: 1.5pt) = {
  box(baseline: shift, height: 10pt, image("/icons/" + name))
  h(3pt)
}

#let findMe(services) = {
  set text(8pt)
  let icon = icon.with(shift: 2.5pt)

  // h(1fr)
  services
    .map(service => {
      if "icon" in service.keys() {
        icon(service.icon)
      } else {
        icon(service.name + ".svg")
      }

      if "display" in service.keys() {
        link(service.link)[#{ service.display }]
      } else {
        link(service.link)
      }
    })
    .join(h(10pt))
  h(1fr)

  parbreak()
}

#let term(period, location) = {
  text(9pt)[#icon("calendar.svg") #period #h(1fr) #icon("location.svg") #location]
}

#let joblike_header(name, period, subtitle: "") = {
  v(2pt)

  [=== #name]
  if subtitle != "" {
    [ \- #subtitle]
  }

  h(1fr)

  icon("calendar.svg")

  period

  v(-5pt, weak: true)
}

#let max_rating = 5
#let skill(name, rating) = {
  let done = false
  let i = 1

  name

  h(1fr)

  while (not done) {
    let colour = rgb("#c0c0c0")
    let strokeColor = rgb("#c0c0c0")
    let radiusValue = (left: 0em, right: 0em)

    if (i <= rating) {
      colour = primary_colour
      strokeColor = primary_colour
    }

    // Add rounded corners for the first and last boxes
    if (i == 1) {
      radiusValue = (left: 2em, right: 0em)
    } else if (i == max_rating) {
      radiusValue = (left: 0em, right: 2em)
    }

    box(rect(
      height: 0.3em,
      width: 1.5em,
      stroke: strokeColor,
      fill: colour,
      radius: radiusValue,
    ))

    if (max_rating == i) {
      done = true
    }

    i += 1
  }

  [\ ]
}


#let styled-link(dest, content) = emph(text(fill: link_colour, link(dest, content)))

#let vantage-cv(
  name: "",
  position: "",
  links: (),
  tagline: [],
  leftSide,
  rightSide,
) = {
  set document(
    title: name + "'s CV",
    author: name,
  )
  set text(10pt, font: "PT Sans")
  set page(
    margin: (x: 0.5in, y: 0.5in),
    paper: "a4",
  )
  set par(linebreaks: "optimized")

  show heading.where(level: 1): it => text(16pt, [
    #align(left)[#{ it.body } #v(-6pt)]
  ])

  show heading.where(
    level: 2,
  ): it => text(fill: primary_colour, [
    #{ it.body }
    #v(-7pt)
    #line(length: 100%, stroke: 0.5pt + primary_colour)
  ])

  show heading.where(
    level: 3,
  ): it => text(it.body)

  show heading.where(
    level: 4,
  ): it => text(
    fill: primary_colour,
    it.body,
  )

  [= #name]
  text(12pt, weight: "medium", [#align(left)[#position]])

  v(-4pt)
  findMe(links)

  tagline

  grid(
    columns: (6fr, 4fr),
    column-gutter: 2em,
    leftSide, rightSide,
  )
}

#let dot_list(
  list,
) = {
  let iter = 0
  let length = list.len()
  for item in list {
    // Attach the dot after the item, then put
    // the entire thing in a box, so that it all
    // travels on one line together, and a dot
    // will never appear at the beginning
    let content = [
      #item
      #if iter != length - 1 {
        [•]
      }
    ]

    [ ]

    box(content)

    iter += 1
  }
}
