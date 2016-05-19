# Adapted from: https://github.com/bcaffo/courses/blob/master/01_DataScientistToolbox/makefile

RMD_FILES  = $(shell find . -type f -name '*.Rmd')
HTML_FILES = $(patsubst %.Rmd, %.html, $(RMD_FILES))
PDF_FILES = $(patsubst %.Rmd, %.pdf, $(RMD_FILES))

all: $(HTML_FILES) $(PDF_FILES)

%.html: %.Rmd
	Rscript -e "source('~/.Rprofile');rmarkdown::render('$<', rmarkdown::html_document(fig_height = 4.5, fig_caption = FALSE))"

%.pdf: %.Rmd
	Rscript -e "source('~/.Rprofile');rmarkdown::render('$<', rmarkdown::pdf_document(fig_caption = FALSE))"

clean:
	rm $(HTML_FILES) $(PDF_FILES)