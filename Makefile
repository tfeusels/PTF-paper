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
TITLE = NIMpaper

# Any files that need to be included.
SOURCES =  $(wildcard *.tex) \
	$(wildcard figures/*.eps) \
	NIMpaper.sty \
	HEPunits.sty \
	NIMpaper.bib

PRODUCTS = $(TITLE).pdf $(TITLE).ps 
INTERIM  = *.toc *.aux *.log *~ *.out *.bbl *.blg *.dvi

# The default target.
all: pdf

ps: $(TITLE).ps
pdf: $(TITLE).pdf

$(TITLE).dvi :: $(SOURCES)

.PRECIOUS: %.dvi %.aux %.bbl

# Remove any default tex rules.
%.dvi : %.tex

# Add a new rule for the latex file.  Notice that latex may be run
# *four* times.    
%.dvi : %.tex 
	latex $*.tex && (\
		if grep bibdata $*.aux >> /dev/null; then \
			echo Running bibtex; \
			bibtex $* >> /dev/null; \
		fi; \
		if grep -v "undefined references" $*.log >> /dev/null; then \
			echo Re-run latex; \
			latex $*.tex >> /dev/null; \
		fi; \
		if grep -v "undefined references" $*.log >> /dev/null; then \
			echo Re-run latex; \
			latex $*.tex >> /dev/null; \
		fi; \
		if grep -v "undefined references" $*.log >> /dev/null; then \
			echo Re-run latex; \
			latex $*.tex; \
		fi )

# Build the postscript file.
%.ps: %.dvi
	dvips -o $@ $<

# Build the pdf file.
# %.pdf: %.ps
# 	ps2pdf $< $@
%.pdf: %.dvi
	dvipdfmx -p letter -o $@ $<

clean:
	rm -f $(INTERIM)

realclean: clean
	rm -f $(PRODUCTS)


