/*
######################################################################################
####################################### CONFIG #######################################
######################################################################################
*/

#let paragraph_indent = 1.25em

/*
######################################################################################
######################################## MATH ########################################
######################################################################################
*/

#let layout = ( wrap: auto, equal: 1fr )

#let math(padding: true, layout: layout.equal, steps) = {
  let r = align(center)[#table(
    inset: 0pt,
    columns: (layout, layout),
    column-gutter: 3pt,
    row-gutter: 15pt,
    align: (right + horizon, left + horizon),
    stroke: none,
    ..steps
  )]
  if padding [ #pad(left: paragraph_indent)[#r] ] else [ #r ]
}

/*
######################################################################################
######################################## CODE ########################################
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
#################################### TEMPLATE_UDS ####################################
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
  begin_chapter_on_new_page: true,
  margin: (horizontal: 2cm, vertical: 1.5cm),
  page_numbering: "- 1 -",
  body,
) = {
  margin = ( 
    horizontal: margin.at("horizontal", default: 2cm),
    vertical: margin.at("vertical", default: 1.5cm),
  )

  set text(lang: "fr")

  set par(first-line-indent: (amount: paragraph_indent, all: true))

  set heading(numbering: "1.a.")

  show heading: it => {
    let above = if it.level == 1 { 3em } else if it.level == 2 { 2em } else { 1.5em }

    let content = if it.level <= 2 { it } else { "•  " + it.body }

    if begin_chapter_on_new_page and it.level == 1 { pagebreak() }
    block(
      above: above,
      below: 1.5em,
      content,
    )
  }

  image("LogoUdS.png", width: 10cm)
  v(1fr)
  align(center)[
    #text(size: 3em, weight: "bold")[#title]

    #if subtitle != none { text(size: 2.6em, weight: "bold")[ #subtitle ] }
    
    #v(2cm)
    #text(size: 1.7em)[#authors]
  ]
  v(1fr)
  text(size: 1.4em)[#session]

  if display_outline {

    if not begin_chapter_on_new_page { pagebreak() }

    align(horizon)[
      #outline(
        title: "Table des matières",
        indent: auto,
        depth: outline_depth,
      )
    ]
  }

  if not begin_chapter_on_new_page { pagebreak() }



  set page(
    margin: (
      left: margin.horizontal,
      right: margin.horizontal,
      top: margin.vertical,
      bottom: margin.vertical,
    ),
    footer: context {
      align(center, text(13pt, counter(page).display(page_numbering)))
    }
  )
  counter(page).update(1)

  body
}
