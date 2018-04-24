############################################################
# Build a paper.
#
# To build:
#
#   make        -- builds the paper and runs dvips.
#   make ps     -- same as above.
#   make pdf    -- builds the paper and runs ps2pdf
#   make clean  -- Removes a lot of the latex detritus, but not the output. 
#   make realclean  -- Removes the latex detritus and the output files.

# The title of the main file (don't include the .tex extension)
TITLE = PTF
TEX = pdflatex
BIB = bibtex

# Any files that need to be included.
SOURCES =  $(wildcard *.tex) \
	$(wildcard figs/*.*) \
	HEPunits.sty 

PRODUCTS = $(TITLE).pdf $(TITLE).ps 
INTERIM  = *.toc *.aux *.log *~ *.out *.bbl *.blg *.dvi

# The default target.
all: pdf

pdf: $(TITLE).pdf

$(TITLE).pdf : $(SOURCES) $(TITLE).bib
	$(TEX) $(TITLE).tex
	$(BIB) $(TITLE).aux
	$(TEX) $(TITLE).tex
	$(TEX) $(TITLE).tex

clean:
	rm -f $(INTERIM) $(PRODUCTS)
