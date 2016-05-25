# Adapted from: https://github.com/bcaffo/courses/blob/master/01_DataScientistToolbox/makefile

RMD_FILES  = $(shell find . -type f -name '*.Rmd')
MAKE_FILES = $(shell find . -type f -name '[M|m]akefile' -mindepth 2)
HTML_FILES = $(patsubst %.Rmd, %.html, $(RMD_FILES))
PDF_FILES = $(patsubst %.Rmd, %.pdf, $(RMD_FILES))
MAKE_DIRS = $(shell dirname $(MAKE_FILES))

all: $(HTML_FILES) $(PDF_FILES)

files:
	@echo $(RMD_FILES)
	@echo $(HTML_FILES)
	@echo $(PDF_FILES)

dirs:
	@echo $(MAKE_DIRS)

%.html: %.Rmd
	cd $(MAKE_DIRS) && $(MAKE)
	Rscript -e "source('~/.Rprofile');rmarkdown::render('$<', rmarkdown::ioslides_presentation(fig_height = 4.5, fig_caption = FALSE, logo = '../../img/bloomberg_shield.png', css = '../../assets/css/slides.css'))"

%.pdf: %.Rmd
	cd $(MAKE_DIRS) && $(MAKE)
	Rscript -e "source('~/.Rprofile');rmarkdown::render('$<', rmarkdown::beamer_presentation(fig_caption = FALSE))"

clean:
	rm $(HTML_FILES) $(PDF_FILES)