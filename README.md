# Typst Template

## Utilisation 

### Template

``` typst
#import "@local/typst_template:1.0.0": *

#show: doc => template(
  title: none,
  subtitle: none,
  authors: (),
  display_outline: true,
  outline_depth: 2, 
  doc
)
```

### Math 

``` typst
#let layout = (
  wrap: auto,
  equal: 1fr,
)

#math(
  padding: true,
  layout: layout.equal,
  (
      [text #h(1fr) $a =$], $1 + 2$,
      $=$, [$3$ #h(1fr) (resp. b)]
  )
)

#math(
  padding: false,
  layout: layout.wrap,
  (
      $a =$, $1 + 2$,
      $=$, $3$
  )
)
```

### Code 


``` typst
#code(
  number: false, 
  start: 10,
  read("file.rs")
)

#code(
  number: true, 
  start: 1,
  end: 10,
  size: 10pt,
  lang: "python",
  "a = 1
b = 2
print(a+b)"
)
```
