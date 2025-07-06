#import "template.typ": *
// #import "@preview/nth:1.0.1": *
#let configuration = yaml("configuration.yaml")


#vantage-cv(
  name: configuration.contacts.name,
  position: configuration.position,
  tagline: eval(mode: "markup", configuration.tagline),
  links: (
    (name: "email", link: "mailto:" + configuration.contacts.email),
    (name: "website", link: configuration.contacts.website.url, display: configuration.contacts.website.displayText),
    (name: "github", link: configuration.contacts.github.url, display: configuration.contacts.github.displayText),
    // (
    //   name: "linkedin",
    //   link: configuration.contacts.linkedin.url,
    //   display: configuration.contacts.linkedin.displayText,
    //   icon: "linkedin.png",
    // ),
    (name: "location", link: "", display: configuration.contacts.address),
    (name: "calendar", link: "", display: configuration.content_last_updated),
  ),
  [
    == Job Experience

    #for job in configuration.jobs [
      #let subtitle = if job.contract == true {
        [Contract]
      } else {
        [Full Time]
      }
      #joblike_header(job.position, subtitle: subtitle, [#job.from --- #job.to])\
      _#link(job.company.link)[#job.company.name]_
      #if job.product.name != "" {
        [ -]
        [ ]
        if job.product.link != "" {
          styled-link(job.product.link)[#job.product.name]
        } else {
          job.product.name
        }
      }

      #for point in job.description [
        - #eval(mode: "markup", point)
      ]
    ]
  ],
  [
    == Education

    #for edu in configuration.education [

      #let school = if edu.place.link != "" [
        #link(edu.place.link)[#edu.place.name]
      ] else [
        [#edu.place.name]
      ]

      #grid(columns: (1fr, auto))[*#school*][#edu.from - #edu.to]

      #v(-3pt)

      #edu.degree in #edu.major #h(1fr) #edu.location

    ]

    == Open Source Experience

    #for open in configuration.open_source [
      #joblike_header(link("https://github.com/" + open.github)[#open.github], [#open.from --- #open.to])\

      #v(-8pt)

      #open.position

      #for point in open.description [
        - #eval(mode: "markup", point)
      ]
    ]

    == Skills

    #dot_list(configuration.skills)

    == Tools

    #dot_list(configuration.tools)

  ],
)
