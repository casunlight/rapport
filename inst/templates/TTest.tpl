<!--head
meta:
  title: t-test Template
  author: Aleksandar Blagotić
  description: A t-test report with table of descriptives, diagnostic tests and t-test
    specific statistics.
  email: ~
  packages: nortest
  example:
  - rapport("TTest", ius2008, x = "leisure", y = "gender")
  - rapport("TTest", ius2008, x = "leisure", mu = 3.2)
inputs:
- name: x
  label: X variable
  description: Dependent (response) variable
  class: numeric
  length:
    min: 1.0
    max: 1.0
  value: ~
  required: yes
  standalone: no
- name: 'y'
  label: Y variable
  description: Independent variable (factor, or another numeric)
  length:
    min: 1.0
    max: 1.0
  value: ~
  required: no
  standalone: no
- name: alter
  label: Alternative hypothesis
  description: Whether two-sided, greater or less variant will be applied
  class: character
  length:
    min: 1.0
    max: 1.0
  options:
  - two.sided
  - less
  - greater
  value: two.sided
  matchable: yes
  allow_multiple: no
  required: no
  standalone: yes
- name: mu
  label: Mean value
  description: Mean value for one-sample t-test
  class: numeric
  length:
    min: 1.0
    max: 1.0
  value: ~
  limit:
    min: -.inf
    max: .inf
  required: no
  standalone: yes
- name: paired
  label: Paired t-test
  description: Carry out paired t-test or not
  class: logical
  length:
    min: 1.0
    max: 1.0
  value: no
  required: no
  standalone: yes
- name: var.equal
  label: Variance equality
  description: 'Equal variances assumed: choose automatically or not'
  class: logical
  length:
    min: 1.0
    max: 1.0
  value: no
  required: no
  standalone: yes
- name: ci.level
  label: Confidence interval
  description: Confidence interval level
  class: numeric
  length:
    min: 1.0
    max: 1.0
  value: 0.95
  limit:
    min: 0.0
    max: 1.0
  required: no
  standalone: yes
head-->
<%=

if (!exists('y') || is.null(y)) {

    ## if y is NULL, you're stuck with one-sample t-test
    arg.list <- list(x = x, mu = mu, alternative = alter, conf.level = ci.level)
    test <- stats:::t.test

    variant <- "one-sample"

} else {

    ## "y" is specified, so it's either independent samples or paired samples
    if (!inherits(y, c('factor', 'numeric')))
        stop('"y" has to be either a factor or a numeric vector')

    arg.list <- list(alternative = alter, paired = paired, var.equal = var.equal, conf.level = ci.level)

    if (is.factor(y)){
       test <- stats:::t.test.formula
       arg.list$formula <- x ~ y
    }

    if (is.numeric(y)){
        test <- stats:::t.test
        arg.list$x <- x
        arg.list$y <- y
    }

    variant <- ifelse(paired, "paired-samples", "independent samples")

}

tt <- do.call(test, arg.list)

%>

# Introduction

In a nutshell, _t-test_ is a statistical test that assesses hypothesis of equality of two means. But in theory, any hypothesis test that yields statistic which follows [_t-distribution_](https://en.wikipedia.org/wiki/Student%27s_t-distribution) can be considered a _t-test_. The most common usage of _t-test_ is to:

 - compare the mean of a variable with given test mean value - **one-sample _t-test_**
 - compare means of two variables from independent samples - **independent samples _t-test_**
 - compare means of two variables from dependent samples - **paired-samples _t-test_**

# Overview

<%= capitalise(variant) %> _t-test_ is carried out with <%= p(x.label) %> as dependent variable<%= if (!is.null(y)) sprintf(", and %s as independent variable", p(y.label)) else ""%>. Confidence interval is set to <%= pct(ci.level * 100, 0) %>. <%= if (!is.null(variant)) sprintf("Equality of variances %s assumed.", ifelse(var.equal, "was", "wasn't")) else "" %>

# Descriptives

In order to get more insight on the underlying data, a table of basic descriptive statistics is displayed below.

<%=
if (is.null(y)) {
    rp.desc(x, NULL, c('min', 'max', 'mean', 'sd', 'var', 'median', 'IQR', 'skewness', 'kurtosis'), rp.data)
} else {
    rp.desc(x, y, c('min', 'max', 'mean', 'sd', 'var', 'median', 'IQR', 'skewness', 'kurtosis'), rp.data)
}
%>

# Diagnostics

Since _t-test_ is a parametric technique, it sets some basic assumptions on distribution shape: it has to be _normal_ (or approximately normal). A few normality test are to be applied, in order to screen possible departures from normality.

## Normality Tests

We will use _Shapiro-Wilk_, _Lilliefors_ and _Anderson-Darling_ tests to screen departures from normality in the response variable (<%= p(x.label) %>).

<%=
(ntest <- htest(x, shapiro.test, lillie.test, ad.test, colnames = c("N", "p")))
%>

As you can see, applied tests <%= ifelse(all(ntest$p < .05), "confirm departures from normality", "yield different results on hypotheses of normality, so you may want to stick with one you find most appropriate or you trust the most.") %>.


# Results

<%= tt$method %> was applied, and significant differences <%= ifelse(tt$p.value < 1 - ci.level, "weren't", "were") %> found.

<%=
with(tt, data.frame(statistic, df = parameter, p = p.value, `CI(lower)` = conf.int[1], `CI(upper)` = conf.int[2], check.names = FALSE))
%>