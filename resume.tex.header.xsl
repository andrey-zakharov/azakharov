<?xml version="1.0"?>
<stylesheet
        xmlns:xlink="http://www.w3.org/1999/xlink"
        xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
        xmlns="http://www.w3.org/1999/XSL/Transform"
        version="1.0">

    <template match = "/">
        \input{predoc}
        <choose>
            <when test="$lang='en'"></when>
            <otherwise>\PolyglossiaSetup{russian}{hyphenmins={3,3}}</otherwise>
        </choose>

        \AtBeginDocument{\setmainlanguage{<choose>
            <when test="$lang='en'">english</when>
            <otherwise>russian</otherwise>
        </choose>}}
        <apply-templates select = '/Document/Meta' />
        \begin{document}
        \makecvtitle
        %\headercols{\blindtext}{\blindtext}{\blindtext}

        \headercols{%
            <apply-templates select = '/Document/Objective' />%
        }{%
            <apply-templates select = '/Document/Languages' />%
        }{%
            <apply-templates select = '/Document/Education[not(@lang) or @lang=$lang]' />%
        }
        <apply-templates select =
            '/Document/Meta/following-sibling::*[not(self::Objective) and not(self::Languages) and not(self::Education) and (not(@lang) or @lang=$lang)]' />
        \end{document}
    </template>

    <!-- proper template for arguments to cvtripleitem -->
    <template match = '/Document/Objective//Entry'>%
        <value-of select = '.' />\newline{}%
    </template>
<!--    <template match = '/Document/Education//Entry'>{<value-of select = '.' />}%</template>-->
    <!-- <template match = '/Document/Languages'>
      \pagebreak\section{<value-of select = 'name()' />}<apply-templates /></template> -->
    <template match = '//Language'>%
        <value-of select = '@name' />: <value-of select = '@skill' />\newline{}%
        %{<value-of select = '.' />}%
    </template>

    <template match = '//Education/Entry'>%
        <value-of select = 'Degree' /> (<apply-templates select = 'Period' />) %
        \textbf{<value-of select = 'Institution' />} %
        \emph{<value-of select = 'Grade' />}\\%
        <value-of select = 'Description' />%
    </template>

    <template match = '//Education/Thesis'>
        \subsection{Master thesis}
        \cvline{title}{\emph{<value-of select = 'Title' />}}
        \cvline{supervisors}{<value-of select = 'Supervisors' />}
        \cvline{description}{\small <value-of select = 'Description' />}
    </template>


</stylesheet>
