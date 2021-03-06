<!--head
meta:
  title: Graphing (Boxplot)
  author: Daniel Nagy
  description: In this template Rapporter will present you boxplot.
  email: ~
  packages:
  - RColorBrewer
  example:
  - rapport('Boxplot.tpl', data=ius2008, var1='age', var2='gender')
  - rapport('Boxplot.tpl', data=ius2008, var1='age', var2='gender', 
            plot.title.pos = "nowhere", var1.lab = "Years of age", 
            var2.lab = "Male or Female?", fontfamily = "symbol", 
            fontcolor = "purple", fontsize = 13, background = "grey")
inputs:
- name: var1
  label: Used Variable 1
  description: This is the first variable that you will use here
  class: numeric
  length:
    min: 1.0
    max: 1.0
  required: yes
  standalone: no
- name: var2
  label: Used Variable 2
  description: This is the factor variable that you will use here
  class: factor
  length:
    min: 1.0
    max: 1.0
  required: no
  standalone: no
- name: plot.title
  label: Title of the plot
  description: This is good to set the title of the plot.
  class: character
  value: default
  matchable: no
  required: no
  standalone: yes
- name: plot.title.pos
  label: Position of the title of the plot
  description: Specifying the position of the title of the plot
  class: character
  options:
  - on the plot
  - outside the plot
  - nowhere
  value: on the plot
  matchable: yes
  allow_multiple: no
  required: no
  standalone: yes
- name: var1.lab
  label: var1 label
  description: This is the name of the var1 label on the plot.
  class: character
  value: default
  matchable: no
  required: no
  standalone: yes
- name: var2.lab
  label: var2 label
  description: This is the name of the var2 label on the plot.
  class: character
  value: default
  matchable: no
  required: no
  standalone: yes
- name: nomargin
  label: Graph no margin
  description: if trying to keep plots' margins at minimal
  class: logical
  value: TRUE
  required: no
  standalone: yes
- name: fontfamily
  label: Family of the font
  description: Specifying the font family to be used in images
  class: character
  options:
  - serif
  - sans
  - mono
  - symbol
  value: sans
  matchable: yes
  allow_multiple: no
  required: no
  standalone: yes
- name: fontcolor
  label: Color of the font
  description: Specifying the default font color
  class: character
  value: black
  matchable: no
  required: no
  standalone: yes
- name: fontsize
  label: Size of the font
  description: Specifying the base font size in pixels
  class: integer
  value: 12
  limit:
    min: 1.0
    max: 50.0
  matchable: no
  required: no
  standalone: yes
- name: grid
  label: Grid
  description: If a grid should be added to the plot
  class: logical
  value: TRUE
  required: no
  standalone: yes
- name: grid.minor
  label: Grid minor
  description: If a miner grid should be also rendered
  class: logical
  value: TRUE
  required: no
  standalone: yes
- name: grid.color
  label: Color of the grid
  description: Specifying the color of the rendered grid
  class: character
  value: grey
  matchable: no
  required: no
  standalone: yes
- name: grid.lty
  label: Line type of the grid
  description: Specifying the line type of grid
  class: character
  options:
  - blank
  - solid
  - dashed
  - dotted
  - dotdash
  - longdash
  - twodash
  value: dashed
  matchable: yes
  allow_multiple: no
  required: no
  standalone: yes
- name: boxes
  label: Graph boxes
  description: If to render a border around of plot (and e.g. around strip)
  class: logical
  value: FALSE
  required: no
  standalone: yes
- name: legend.position
  label: Position of the legend
  description: Specifying the position of the legend
  class: character
  options:
  - top
  - right
  - bottom
  - left
  value: right
  matchable: yes
  allow_multiple: no
  required: no
  standalone: yes
- name: background
  label: Background's color
  description: Specifying the plots main background's color
  class: character
  value: white
  matchable: no
  required: no
  standalone: yes
- name: colp
  label: Color palette
  description: Color paletter from colorbrewer.com
  required: no
  class: character
  value: Set1
  length:
    min: 1.0
    max: 1.0  
  matchable: yes
  standalone: yes
  options:
  - BrBG
  - PiYG
  - PRGn
  - PuOr
  - RdBu
  - RdGy
  - RdYlBu
  - RdYlGn
  - Spectral
  - Accent
  - Dark2
  - Paired
  - Pastel1
  - Pastel2
  - Set1
  - Set2
  - Set3
  - Blues
  - BuGn
  - BuPu
  - GnBu
  - Greens
  - Greys
  - Oranges
  - OrRd
  - PuBu
  - PuBuGn
  - PuRd
  - Purples
  - RdPu
  - Reds
  - YlGn
  - YlGnBu
  - YlOrBr
  - YlOrRd
  allow_multiple: no
- name: color.rnd
  label: Reordered colors
  description: Specifying if the palette should be reordered randomly before rendering each plot to get colorful images
  class: logical
  value: FALSE
  required: no
  standalone: yes
- name: axis.angle
  label: Angle of the axes
  description: Specifying the angle of axes' labels
  class: integer
  limit:
    min: 1.0
    max: 4.0
  value: 1.0
  matchable: no
  required: no
  standalone: yes
- name: symbol
  label: Specifying a symbol
  description: Specifying a symbol
  class: integer
  value: 1
  matchable: no
  required: no
  standalone: yes
head-->

<%=

if (nomargin != TRUE) panderOptions('graph.nomargin', nomargin)
if (fontfamily != "sans") panderOptions('graph.fontfamily', fontfamily)
if (fontcolor != "black") panderOptions('graph.fontcolor', fontcolor)
if (fontsize != 12) panderOptions('graph.fontsize', fontsize)
if (grid != TRUE) panderOptions('graph.grid', grid)
if (grid.minor != TRUE) panderOptions('graph.grid.minor', grid.minor)
if (grid.color != "grey") panderOptions('graph.grid.color', grid.color)
if (grid.lty != "dashed") panderOptions('graph.grid.lty', grid.lty)
if (boxes != FALSE) panderOptions('graph.boxes', boxes)
if (legend.position != "right") panderOptions('graph.legend.position', legend.position)
if (background != "white") panderOptions('graph.background', background)
if (color.rnd != FALSE) panderOptions('graph.color.rnd', color.rnd)
if (axis.angle != 1) panderOptions('graph.axis.angle', axis.angle)
if (symbol != 1) panderOptions('graph.symbol', symbol)
cs <- brewer.pal(brewer.pal.info[which(rownames(brewer.pal.info) == colp),1], colp)
if (colp != "Set1") panderOptions('graph.colors', cs)


if (length(var2) == 0) {
var1 <- na.omit(var1)
if (var1.lab == "default")  var1_lab <- sprintf(var1.label)
} else {
NAs <- which(is.na(var1) | is.na(var2))
var1 <- var1[-NAs]
var2 <- var2[-NAs]
if (var1.lab == "default")  var1_lab <- sprintf(var1.label)
if (var2.lab == "default")  var2_lab <- sprintf(var2.label)
}


if (length(var2) == 0) {
if (plot.title == "default")  {
main_lab <- sprintf('Boxplot of %s',var1.name)
} else {
main_lab <- plot.title
}
} else {
if (plot.title == "default") { 
main_lab <- sprintf('Boxplot of %s and %s',var1.name, var2.name)
} else {
main_lab <- plot.title
}}


if (length(var2) == 0) {
set.caption(ifelse(plot.title.pos == "outside the plot", main_lab, ""))
suppressWarnings(bwplot(var1, main = ifelse(plot.title.pos == "on the plot", main_lab, ""), xlab = ifelse(var2.lab == "default", var1_lab, var1.lab)))
} else {
set.caption(ifelse(plot.title.pos == "outside the plot", main_lab, ""))
suppressWarnings(bwplot(var1 ~ var2, main = ifelse(plot.title.pos == "on the plot", main_lab, ""), xlab = ifelse(var2.lab == "default", var2_lab, var2.lab), ylab = ifelse(var1.lab == "default", var1_lab, var1.lab)))
}
%>


