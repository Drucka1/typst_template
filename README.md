# Typst Template

## Folder 

``` typst 
~/snap/code/211/.local/share/typst/packages/local/
``` 

## Utilisation 


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

#math(
    padding: true,
    layout: layout.equal,
    (
        [text #h(1fr) $a =$], $1 + 2$,
        $=$, [$3$ #h(1fr) (resp. b)]
    )
)
```