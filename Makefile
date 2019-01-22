#
#
#

RM = rm -f
SED = sed
VIEW_PDF ?= okular
VIEW_HTML ?= x-www-browser

LATEX2PDF = pdflatex -file-line-error -interaction=nonstopmode
XSLTPROC = xsltproc --stringparam lang $(PROJ_LANG)
PROJ = resume
PROJ_LANG ?= en
TARGET_TEX = $(PROJ).$(PROJ_LANG).tex
TARGET_HTML = $(PROJ).$(PROJ_LANG).html
TARGET_PDF = $(PROJ).$(PROJ_LANG).pdf
TARGET_XML = $(PROJ).$(PROJ_LANG).xml

XML2TEX_XSLT = $(PROJ).tex.xsl

.PHONY: preview preview-pdf preview-html all pdf xml $(PROJ).xml

#default
all: pdf html

preview: preview-html preview-pdf

preview-html:
	[ -r ./$(TARGET_HTML) ] && ( $(VIEW_HTML) ./$(TARGET_HTML) & )

preview-pdf:
	[ -r ./$(TARGET_PDF) ] && ( $(VIEW_PDF) $(TARGET_PDF) & )

pdf: $(TARGET_TEX)
	@$(LATEX2PDF) $(TARGET_TEX)

$(PROJ).%: $(PROJ).xml
	@$(XSLTPROC) --output $(@:$*=$(PROJ_LANG).$*) $@.xsl $(PROJ).xml

$(TARGET_TEX): $(PROJ).xml
	( $(SED) 's!C#!C\\#!' $(PROJ).xml | $(XSLTPROC) $(XML2TEX_XSLT) - | $(SED) 's!&!\\&!' > $(TARGET_TEX))

clean:
	$(RM) *.log *.out *~ *.aux \
	*.4ct *.4tc *.bbl *.blg *.dvi *.idv *.lg *.tmp *.xref

distclean:
	$(RM) $(TARGET_TEX) $(TARGET_HTML) $(TARGET_PDF)

ttex:
	@$(XSLTPROC) $(XML2TEX_XSLT) $(PROJ).xml
