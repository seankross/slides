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
	Rscript -e "source('~/.Rprofile');rmarkdown::render('$<', rmarkdown::ioslides_presentation(fig_height = 4.5, fig_caption = FALSE, logo = '../../img/bloomberg_shield.png', css = '../../assets/css/slides.css'))"

%.pdf: %.Rmd
	Rscript -e "source('~/.Rprofile');rmarkdown::render('$<', rmarkdown::beamer_presentation(fig_caption = FALSE))"

clean:
	rm $(HTML_FILES) $(PDF_FILES)