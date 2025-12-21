#
# Makefiles - is the simplest declarative form of processing graph steps
# I LOVE everything simple but powerful.
# Here is dumpest computational flow graph xml -> pdf, html and it does not work :)
# CI here? :)
#
# Could be called with env vars:
#  PROJ_LANG=[ru,en] make md
# Valid targets:
#  pdf
#  html
#  txt

# Big TO BE DONE: separate build and dist folders from sources
# choco install texlive xsltproc
PROJ = AndreyZakharov
PROJ_LANG ?= en

RM = rm -f
SED = sed
VIEW_PDF ?= okular
VIEW_HTML ?= x-www-browser

LATEX2PDF = lualatex -file-line-error -interaction=nonstopmode -halt-on-error
XSLTPROC = xsltproc --encoding utf8 --load-trace --stringparam lang $(PROJ_LANG)


TARGET_TEX = $(PROJ).$(PROJ_LANG).tex
TARGET_HTML = $(PROJ).$(PROJ_LANG).html
TARGET_PDF = $(PROJ).$(PROJ_LANG).pdf
TARGET_XML = $(PROJ).$(PROJ_LANG).xml
TARGET_TXT = $(PROJ).$(PROJ_LANG).md

XML2TEX_XSLT = resume.tex.xsl
XML2TXT_XSLT = resume.md.xsl

.PHONY: preview preview-pdf preview-html all pdf xml $(PROJ).xml texlive.libs

#default
all: pdf html txt json

preview: preview-html preview-pdf

preview-html:
	[ -r ./$(TARGET_HTML) ] && ( $(VIEW_HTML) ./$(TARGET_HTML) & )

preview-pdf:
	[ -r ./$(TARGET_PDF) ] && ( $(VIEW_PDF) $(TARGET_PDF) & )

pdf: $(PROJ).$(PROJ_LANG).tex
	$(SED) 's_&_\\\&_' $(PROJ).$(PROJ_LANG).tex > escaped.$(PROJ_LANG).tex
	mv escaped.$(PROJ_LANG).tex $(PROJ).$(PROJ_LANG).tex
	$(LATEX2PDF) $(PROJ).$(PROJ_LANG).tex

txt: $(PROJ).$(PROJ_LANG).md

html: $(PROJ).$(PROJ_LANG).html

json: $(PROJ).$(PROJ_LANG).json

texlive.libs:
	tlmgr install moderncv polyglossia luatexbase pgf tikzmark qrcode contour newcomputermodern lh collection-langcyrillic
	fmtutil-sys --all

clean:
	$(RM) *.log *.out *~ *.aux \
	*.4ct *.4tc *.bbl *.blg *.dvi *.idv *.lg *.tmp *.xref \
	*.prepared4xslt

distclean:
	$(RM) $(PROJ).en.* $(PROJ).ru.*

$(PROJ).prepared4xslt: $(PROJ).xml
	$(SED) 's_C#_C\\\#_' $< > $@

$(PROJ).$(PROJ_LANG).%: $(PROJ).prepared4xslt resume.tex.xsl resume.md.xsl resume.html.xsl resume.json.xsl
	@echo Using resume.$*.xsl
	$(XSLTPROC) resume.$*.xsl $(PROJ).prepared4xslt > $@

