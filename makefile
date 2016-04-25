# Adapted from: https://github.com/bcaffo/courses/blob/master/01_DataScientistToolbox/makefile

RMD_FILES  = $(shell find . -type f -name '*.Rmd')
HTML_FILES = $(patsubst %.Rmd, %.html, $(RMD_FILES))
PDF_FILES = $(patsubst %.Rmd, %.pdf, $(RMD_FILES))

all: $(HTML_FILES) $(PDF_FILES)

files:
	@echo $(RMD_FILES)
	@echo $(HTML_FILES)
	@echo $(PDF_FILES)

%.html: %.Rmd
	Rscript -e "rmarkdown::render('$<')"

%.pdf: %.Rmd
	Rscript -e "rmarkdown::render('$<', rmarkdown::beamer_presentation())"

clean:
	rm $(HTML_FILES) $(PDF_FILES)