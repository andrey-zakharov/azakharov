<?xml version="1.0"?>
<stylesheet 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  <output method="text" media-type="text/x-tex" />
    <param name = "lang" >en</param>
  <template match = "*[ @xlink:role = 'locator' ]">
    <choose>
      <when test = 'text()'> \href{<value-of select = "@xlink:href" />}{<value-of select = "." />} </when>
      <otherwise>   \url{<value-of select = "@xlink:href" />}      </otherwise>
    </choose>
  </template>
  
  <template match = "/">
%
\documentclass[10pt,a4paper]{moderncv}
%\renewcommand*{\addresssymbol}{\CircledA}
\moderncvtheme[cerulean]{contemporary}
%\usepackage[T2A]{fontenc}
\usepackage[utf8]{inputenc}
%\usepackage[russian]{babel}
\definecolor{addresscolor}{rgb}{0.35,0.35,0.35}
\usepackage{lmodern}
\usepackage[hmargin=0.5in,vmargin=10pt]{geometry}

\usepackage{url}
\usepackage{tikz}
\usetikzlibrary{tikzmark}
\usetikzlibrary{shapes.symbols, positioning} % Load necessary libraries
\newenvironment{myitemize}%
  {\begin{list}{}{%
    \setlength{\labelwidth}{0pt}
    \setlength{\itemindent}{0em}
    \setlength{\leftmargin}{1em}
  }}%
  {\end{list}}

  \newcommand*{\cvlongentry}[7][.25em]{%
    \cvitem[#1]{#2}{%
      {\bfseries#3}%
      \ifthenelse{\equal{#4}{}}{}{, {\slshape#4}}%
      \ifthenelse{\equal{#5}{}}{}{, #5}%
      \ifthenelse{\equal{#6}{}}{}{, #6}%
      %\ifx&amp;#7&amp;%
      %\else{%--b \begin{myitemize}\item{\small{#7}}\end{myitemize}}
        \hspace{1em}\small{#7}
      %\fi
      }
    }
<!--  \renewcommand*{\cvlongentry}[7][.25em]{%-->
<!--  \cvitem[#1]{#2}{%-->
<!--  {\bfseries#3}%-->
<!--  \ifthenelse{\equal{#4}{}}{}{, {\slshape#4}}%-->
<!--  \ifthenelse{\equal{#5}{}}{}{, #5}%-->
<!--  \ifthenelse{\equal{#6}{}}{}{, #6}%-->
<!--  \strut%-->
<!--  \ifx&amp;#7&amp;%-->
<!--  \else{\newline{}\begin{minipage}[t]{\linewidth}\small#7\end{minipage}}\fi}}-->

<!--\addtolength{\parskip}{-5pt}-->
\AtBeginDocument{\recomputelengths}
  <apply-templates select = '/Document/Meta' />
  \begin{document}
<!--    %\begin{tikzpicture}[remember picture,overlay]-->
<!--    %\fill[color1!30]-->
<!--    %(current page.north west) rectangle ([yshift=-1cm]current page.east|-{pic cs:end});-->
<!--    %\end{tikzpicture}-->
    \makecvtitle
<!--    %\tikzmark{end}-->
<apply-templates select = '/Document/Meta/following-sibling::*[not(@lang) or @lang=$lang]' />
  \end{document}
  </template>

  <template match = 'Project'>\item{\textbf{<value-of
          select = '@name' />}: <value-of
          select = 'Description[@lang = $lang]' />}</template>

  <!-- Meta -->
  <template match="Period">\raggedleft{{\scriptsize <value-of select = "substring-before(@From, ' ')" />}<value-of select = "substring-after(@From, ' ')" />\,--}
    \newline\raggedright{{\scriptsize <value-of select = "substring-before(@To, ' ')" />}<value-of select = "substring-after(@To, ' ')" />}
  </template>
  
  <template match = '/Document/Meta'><apply-templates select = "*[@lang = $lang]" /></template>
  <template match = '/Document/Meta/Personal'><apply-templates /></template>
  <template match = '//Meta/Title'>\title{\today}</template>
  <template match = '//Personal/FirstName'>\firstname{<value-of select = '.' />}</template>
  <template match = '//Personal/FamilyName'>\familyname{<value-of select = '.' />}</template>
  <template match = '//Personal/Address'>\address{\color{black}<value-of select = '.' />\color{addresscolor}}{}</template>
  <template match = '//Personal/Phone'>
    <if test = '@type = "cell"'>\mobile</if>{<value-of select = '.' />}</template>
  <template match = '//Personal/Email'>\email{<value-of select = '.' />}</template>
  <template match = '//Personal/Telegram'>\social[telegram]{<value-of select = "." />}</template>
  <template match = '//Personal/LinkedIn'>\social[linkedin]{<value-of select = "." />}</template>
  <!-- TBD replace(., '_', '\_') -->
  <template match = '//Personal/Extra[ @type = "skype" ]'>
    \extrainfo{skype: \color{black}<value-of select = '.' />}</template>
  <template match = '//Personal/Extra'>\extrainfo{<value-of select = '.' />}</template>
  <template match = '//Personal/Photo'>\photo[<value-of select = '@width' />][2pt]{<value-of select = '.' />}</template>

  <template match = '/Document/*'>
    \section<choose>
      <when test="name() = 'Objective'">[\faBullseye]</when>
      <when test="name() = 'Strengths'">[\faLink]</when>
      <when test="name() = 'Skills'">[\faMagic]</when>
      <when test="name() = 'Experience'">[\faThumbsUp]</when>
      <when test="name() = 'Education'">[\faGraduationCap]</when>
      <when test="name() = 'Languages'">[\faLanguage]</when>
      <when test="name() = 'Links'">[\faAddressBook ]</when>
    </choose>{<value-of select = 'name()' />}
    <apply-templates select = "*[not(@lang) or @lang = $lang]" />
  </template>

  <template match = '/Document/*/*'>
    \subsection{<choose>
      <when test = "@type"><value-of select = '@type' /></when>
      <otherwise><value-of select = 'name()' /></otherwise>      
    </choose>}
    <apply-templates /></template>

  <template match = '/Document/Experience/Vocational'><apply-templates /></template>
 
  <template match = '/Document/*//Entry'><choose><when
          test = '@type'>\cvline{<value-of select = '@type'
  />}</when><otherwise>\cvlistitem</otherwise></choose>{<value-of select = '.' />}
  </template>

  <template match = "//Entry[@xlink:href]">\cvline{<value-of select = '@type' />}{\url{<value-of select = '@xlink:href' />}}
  </template>

  <template match = '//Education/Entry'>\cventry{<apply-templates select = 'Period' />}{<value-of select = 'Degree' />}{<value-of select = 'Institution' />}{<value-of select = 'City' />}{\textit{<value-of select = 'Grade' />}}{<value-of select = 'Description' />}</template>
  
  <template match = '//Education/Thesis'>
\subsection{Master thesis}
\cvline{title}{\emph{<value-of select = 'Title' />}}
\cvline{supervisors}{<value-of select = 'Supervisors' />}
\cvline{description}{\small <value-of select = 'Description' />}
  </template>
  
  <template match = '//Achievement'>\item{<value-of select = '.' />}
  </template>
  
  
  <template match = '//Experience//Entry'>\cventry{<apply-templates select = 'Period' />}{<value-of select = '@Job' />}{<value-of
          select = 'Employer/Name' />}{<value-of select = 'Employer/City' />}{<copy-of select = 'Employer/Description' />}{<apply-templates
          select = 'Description' />\begin{itemize}<if
          test = 'Employer/Customer'>\item Customer: <value-of select = 'Employer/Customer' /></if><if
          test = 'Project'>\item <choose><when test="$lang='ru'">Проекты</when><otherwise>Projects</otherwise></choose>:\begin{itemize}<apply-templates
            select = 'Project' />\end{itemize}</if><if test = 'Achievement'>\item Responsibilities:\begin{itemize}<apply-templates select = "Achievement[@lang = $lang]" />\end{itemize}</if>\end{itemize}}
  </template>
  <!--    <comment>\newline{}
      Key technologies and languages: <value-of select = 'Techs' /></comment>-->

  <!-- <template match = '/Document/Languages'>
    \pagebreak\section{<value-of select = 'name()' />}<apply-templates /></template> -->
  <template match = '//Language'>\cvlanguage{<value-of select = '@name' />}
    {<value-of select = '@skill' />}{<value-of select = '.' />\hfill}</template>
    
<!--   <template match = '/Document/Skills'>\section{Skills}<apply-templates /></template>
  <template select = '/Document/Skills/Group[@lang = $lang]'>\subsection{<value-of select = '@type' />}<apply-templates /></template>
  <template match = '/Document/Skills//Entry'><choose><when test = '@type'>\cvline{<value-of select = '@type' />}</when><otherwise>\cvlistitem</otherwise></choose>{<value-of select = '.' />}</template>
   -->
  <template match = '/Document/Programs'>\section{Programs and scripts}<apply-templates /></template>
  <template match = '/Document/Programs/Entry'><choose><when test = '@type'>\cvline{<value-of select = '@type' />}</when><otherwise>\cvlistitem</otherwise></choose>{<value-of select = '.' />}
  </template>
  
  <template match = '/Document/Portfolio/*'><apply-templates /></template>
  
  <template match = '/Document/Bibliography'>\begin{thebibliography}{9}
    <apply-templates />
  \end{thebibliography}</template>
  <template match = '/Document/Bibliography/Entry'>\bibitem{}
    \href{<value-of select = '@Url' />}{<value-of select = '@Title' />}. <value-of select = '@Url' />, <value-of select = '@Year' />
  </template>

</stylesheet>