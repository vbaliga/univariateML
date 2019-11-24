## Review checklist for @vbaliga
### Conflict of interest

- [x] I confirm that I have read the [JOSS conflict of interest (COI) policy](https://github.com/openjournals/joss/blob/master/COI.md) and that: I have no COIs with reviewing this work or that any perceived COIs have been waived by JOSS for the purpose of this review.

### Code of Conduct

- [x] I confirm that I read and will adhere to the [JOSS code of conduct](https://joss.theoj.org/about#code_of_conduct).

### General checks

- [x] **Repository:** Is the source code for this software available at the <a target="_blank" href="https://github.com/JonasMoss/univariateML">repository url</a>?
- [x] **License:** Does the repository contain a plain-text LICENSE file with the contents of an [OSI approved](https://opensource.org/licenses/alphabetical) software license?

I see there's been some discussion about the License formatting but that @arfon has instructed to keep things as they are. So I will just check this off.

- [x] **Contribution and authorship:** Has the submitting author (@JonasMoss) made major contributions to the software? Does the full list of paper authors seem appropriate and complete?

### Functionality

- [ ] **Installation:** Does installation proceed as outlined in the documentation?

Yes, although I note that using either `devools::check()` or `devtools::install_github("JonasMoss/univariateML", build_vignettes = TRUE)` fails when attempting to create vignettes. This is likely because of how `copula` is needed but not installed & loaded by the "Copula Modeling" vignette. I suggest revising how `copula` is handled within this vignette just so that users who want local vignettes don't have a hard time

- [x] **Functionality:** Have the functional claims of the software been confirmed?
- [ ] **Performance:** If there are any performance claims of the software, have they been confirmed? (If there are no claims, please check off this item.)

Language such as "quick, easy, and free of bugs" is used in a few places, but I don't see any specifics on how the custom-made optimizers perform. I am familiar enough with many of them that I can attest to their veracity in fitting parameters (and they are well-covered by the package's `testthat`), but speed or efficiency haven't been documented. I do agree that `univariateML` provides a lot of convenience. But if language like "quick" is going to be used, it should be backed up with evidence.

### Documentation

- [x] **A statement of need:** Do the authors clearly state what problems the software is designed to solve and who the target audience is?

I'm happy enough with the writing to check off the box here, but please note that other items in this review do relate to this topic.

- [x] **Installation instructions:** Is there a clearly-stated list of dependencies? Ideally these should be handled with an automated package management solution.
- [x] **Example usage:** Do the authors include examples of how to use the software (ideally to solve real-world analysis problems).

- [ ] **Functionality documentation:** Is the core functionality of the software documented to a satisfactory level (e.g., API method documentation)?

This is generally covered well, but I'll make a few suggestions to enhance clarity and/or make life easier for people who are encountering the package for the first time.

Please link to your documentation site more directly within the README of the github repository. I realize there's a Documentation header inside the readme, but I'd also link to the main site (https://univariateml.netlify.com/index.html) at the top of the github repo (i.e. above the Topics) as well as within the Overview section. 

Within the documentation site, please re-order the Articles dropdown menu so that the vignettes are listed in an order that's friendly to new users (i.e. put the Overview vignette first). This can be done by further editing the `_pkgdown.yml` in the root directory.

Within the Distributions vignette, I'd make it a little more clear that the Estimator column refers to functions within your `univariateML` package. I think this can be done via renaming the column and reordering the column names to: Name, univariateML Function, Parameters, Support, Package.

In the Copula vignette, the last line of the first section notes that the package can be used to "speed up task 1" (fitting marginal distributions), but the specifics of how speedy this is (e.g. with run times) or how it compares to approaches via other packages isn't shown. Again, I think that if speed or efficiency are invoked, there should be evidence shown. Or the language could just be revised.

- [x] **Automated tests:** Are there automated tests or manual steps described so that the functionality of the software can be verified?

I'm happy with what I see here! Very nicely thought out. I did not catch any errors.

- [x] **Community guidelines:** Are there clear guidelines for third parties wishing to 1) Contribute to the software 2) Report issues or problems with the software 3) Seek support

I like the update you made following the other reviewer's comments. Looks good!

### Software paper

- [x] **Summary:** Has a clear description of the high-level functionality and purpose of the software for a diverse, non-specialist audience been provided?

I'm happy enough with the language to check this off, but I'll also note that the first sentence of the paper could be tweaked to be a bit more descriptive. I like the language used in both the README and the Overview vignette -- it's nice to have a lead statement that gives me a full sense of what the package does in a punchy way. But this is a minor comment and not one that I'm looking to have enforced. 

- [x] **A statement of need:** Do the authors clearly state what problems the software is designed to solve and who the target audience is?
- [ ] **State of the field:** Do the authors describe how this software compares to other commonly-used packages?

I'd recommend expanding this further. Right now, the paper mentions how this package compares to `stats4::mle()` but does not really go into enough detail about the specific benefits of using `univariateML`'s functions. 

Within the paper, can you give at least one example of a custom-made optimizer within `univariateML` and show how this optimizer's performance fares against what is built into base R or another package? How have other functions let us down?

I suspect that the ability to fit each distribution is already available through other R packages (and this seems to be somewhat confirmed by the table in the Distributions vignette). If there are any distributions that are not covered by other packages, please make this explicit in the paper by specifying the name of the `univariateML` estimator function.

I also think there is merit to incorporating more of a "one stop shop" argument in here. It's convenient to have all of these functions within the same package, especially as they feed nicely into the "Data analysis aids" functions, which I'd argue are are the most important parts of the package. So I recommend that the language of the paper be further adjusted to tell the reader why it's good to use this package instead of relying on what is already out there.

- [x] **Quality of writing:** Is the paper well written (i.e., it does not require editing for structure, language, or writing quality)?
- [x] **References:** Is the list of references complete, and is everything cited appropriately that should be cited (e.g., papers, datasets, software)? Do references in the text use the proper [citation syntax]( https://rmarkdown.rstudio.com/authoring_bibliographies_and_citations.html#citation_syntax)?



## Additional comments

Hi @JonasMoss and @arfon,

Thanks for giving me extra time to review this. I'm generally very impressed with `univariateML` and I can see myself using it. I'd say the vast majority of my comments are geared towards enhancing clarity of presentation, especially for anyone new to the package. Checklist above has been updated.

I have a few more comments that don't exactly fit into the JOSS review checklist, so I will paste them here.

Best regards,
Vikram
 🐢 

#### Additional comments:

- I suggest inserting a `_` within the names of the maximum likelihood estimator functions. I had some trouble distinguishing function names like `mllnorm()` from `mlnorm()` as I tested things out. Having the `_` could help here, e.g. `ml_lnorm()` vs `ml_norm()` is easier for me to distinguish.
- Any interest in creating a delta AIC function? I.e. take the `data.frame` made by `stats::AIC()`, find the minimum AIC value and calculate the delta of each model's AIC from that? Not sure if this already exists elsewhere, but I assume not since you custom-wrote a few lines in your vignettes. But it could be a nice addition to the "Data analysis aids" set of functions that basically supersedes `stats::AIC()` by giving the AICs and also deltas (and maybe AICcs if the user prefers?)
- I also have a suggestion that I'll leave entirely optional at this point: You might give some thought to the 'ecosystem' approach of integrating `univariateML` with your previous `kdensity` package. Can objects made from one package be used by the other in a convenient way? If so, it might be nice to have a 4th vignette demonstrating this and/or some language in the JOSS paper. 

#### Some relatively minor spelling/grammatical/formatting things:

- Within the Overview vignette, the first line does not resolve into a bulleted list (at least on the rendered Netlify site)
- Also in the Overview, section "Comparing Many Models with AIC": please revise the line "The generic in `R` can take multiple models, and the lower the the better" so that it's clearer to your reader that the second half of the sentence refers specifically to AIC values. 
- Also in the Overview vignette, section "Confidence Intervals", sentence 2: Change "Do do" to "To do"
- In the "Copula Modeling" vignette: "...the copula is know,..." should be "...the copula is known,..."
- `spelling::spell_check_package()` yields mostly false positives, but there are a couple items (e.g. "similarily" in `ProbabilityPlots.Rd:68`) that merit correction