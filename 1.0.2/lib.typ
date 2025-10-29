#let horizontal_margin = 2cm
#let vertical_margin = 1.5cm
#let paragraph_indent = 1.25em

/*
######################################################################################
######################################################################################
*/

#let layout = (
  wrap: auto,
  equal: 1fr,
)

#let math(padding: true, layout: layout.equal, steps) = [
  #let r = align(center)[#table(
    inset: 0pt,
    columns: (layout, layout),
    column-gutter: 3pt,
    row-gutter: 15pt,
    align: (right + horizon, left + horizon),
    stroke: none,
    ..steps
  )]
  #if padding [ #pad(left: paragraph_indent)[#r]] else [ #r ]
]

/*
######################################################################################
######################################################################################
*/

#let code(
  number: true,
  lang: none,
  size: 11pt,
  start: 1,
  end: none,
  code
) = block(
  fill: luma(93%),
  inset: (top: 8pt, bottom: 8pt, left: 5pt),
  width: 100%,
  {
    let lines = code.split("\n")
    let total = lines.len()

    let start = if start <= 1 { 1 } else if start > total { total + 1 } else {start}
    let end = if end == none { total } else if end < start { start - 1 } else if end > total { total } else { end }

    let slice = lines.slice(start - 1, end)

    if number {
      grid(
        columns: (auto, auto),
        column-gutter: 0.5em,
        row-gutter: 0.3em,
        align: (right, left),
        ..for (i, line) in slice.enumerate() {
          (
            text(fill: luma(0), size: size)[#(i + start)],
            text(fill: luma(0), size: size, raw(lang: lang, line)),
          )
        }
      )
    } else {
      text(fill: luma(0), size: size, raw(lang: lang, slice.join("\n")))
    }
  },
)

/*
######################################################################################
######################################################################################
*/

#let template_uds(
  title: none,
  subtitle: none,
  session: "Automne 2025",
  authors: (),
  display_outline: true,
  outline_depth: 2,
  paragraph_indent: paragraph_indent,
  body,
) = {
  set page(margin: (
    left: horizontal_margin,
    right: horizontal_margin,
    top: vertical_margin,
    bottom: vertical_margin,
  ))

  set text(lang: "fr")

  set par(
    first-line-indent: (amount: paragraph_indent, all: true),
  )

  set heading(numbering: "1.a.")

  show heading: it => {
    let (above, below) = if it.level == 1 {
      (3em, 1.5em)
    } else if it.level == 2 {
      (2em, 1.5em)
    } else {
      (1.5em, 1.5em)
    }

    let content = if it.level <= 2 { it } else { "•  " + it.body }

    block(
      above: above,
      below: below,
      content,
    )
  }

  image("LogoUdS.png", width: 10cm)
  v(1fr)
  align(center)[
    #text(size: 3em, weight: "bold")[#title]

    #if subtitle != none {
      text(size: 3em, weight: "bold")[ #subtitle ]
    }
    #v(1cm)
    #text(size: 1.7em)[#authors]
  ]
  v(1fr)
  text(size: 1.4em)[#session]

  pagebreak()

  if display_outline {
    align(horizon)[
      #outline(
        title: "Table des matières",
        indent: auto,
        depth: outline_depth,
      )
    ]

    pagebreak()
  }

  body
}
