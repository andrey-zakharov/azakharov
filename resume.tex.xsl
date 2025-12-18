<?xml version="1.0"?>
<stylesheet 
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  version="1.0">
  <output method="text" media-type="text/x-tex"/>
    <param name = "lang" >en</param>
  <template match = "*[ @xlink:role = 'locator' ]">%
    <choose>
      <when test = 'text()'> \href{<value-of select = "@xlink:href" />}{<value-of select = "." />} </when>
      <otherwise>   \url{<value-of select = "@xlink:href" />}      </otherwise>
    </choose>%
  </template>

  <template match = 'Project'>\item{\textbf{<value-of
          select = '@name' />}: <value-of
          select = 'Description[@lang = $lang]' />}</template>

  <template match="Period">%
    <variable name="fromYear" select="substring-after(@From, ' ')" />%
    <variable name="untilYear" select="substring-after(@To, ' ')" />%
    <choose>

      <when test="$fromYear = $untilYear">\raggedleft{%
    {\scriptsize <value-of select = "substring-before(@From, ' ')" />}<value-of select = "$fromYear" />\,--}%
      \raggedright{{\scriptsize <value-of select = "substring-before(@To, ' ')" />}<value-of select = "$untilYear" />}%
      </when>


      <otherwise>\raggedleft{<value-of select = "$fromYear" />\,--}%
        \raggedright{<value-of select = "$untilYear" />}%
      </otherwise>

    </choose>
  </template>
  <!-- Meta -->
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

  <template match = '/Document/*'>\section<choose>
      <when test="name() = 'Objective'">[\faBullseye]</when>
      <when test="name() = 'Strengths'">[\faLink]</when>
      <when test="name() = 'Skills'">[\faMagic]</when>
      <when test="name() = 'Experience'">[\faThumbsUp]</when>
      <when test="name() = 'Education'">[\faGraduationCap]</when>
      <when test="name() = 'Languages'">[\faLanguage]</when>
      <when test="name() = 'Links'">[\faAddressBook ]</when>
    </choose>{%
      <choose>
        <when test="$lang='en'"><value-of select = 'name()' /></when>
        <otherwise>%
          <choose>
            <when test="name() = 'Objective'">Цель</when>
            <when test="name() = 'Strengths'">Сильные стороны</when>
            <when test="name() = 'Skills'">Навыки</when>
            <when test="name() = 'Experience'">Опыт</when>
            <when test="name() = 'Education'">Образование</when>
            <when test="name() = 'Languages'">Языки</when>
            <when test="name() = 'Links'">Ссылки</when>
            <otherwise><value-of select = 'name()' /></otherwise>
          </choose>%
        </otherwise>
      </choose>%
    }%
    <apply-templates select = "*[not(@lang) or @lang = $lang]" />%
  </template>
  <template match = '//Cloud'>\cloud%</template>
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

  <template match = '//Achievement'>\item{<value-of select = '.' />}
  </template>
  
  
  <template match = '//Experience//Entry'>\cventry{<apply-templates select = 'Period' />}%
    {<value-of select = '@Job' />}%
    {<value-of select = 'Employer/Name' />}%
    {<value-of select = 'Employer/City' />}%
    {<copy-of select = 'Employer/Description' />}%
    {<apply-templates
          select = 'Description' />\begin{itemize}<if
          test = 'Employer/Customer'>\item Customer: <value-of select = 'Employer/Customer' /></if><if
          test = 'Project'>\item <choose><when test="$lang='ru'">Проекты</when><otherwise>Projects</otherwise></choose>:\begin{itemize}<apply-templates
            select = 'Project' />\end{itemize}</if><if test = 'Achievement'>\item Responsibilities:\begin{itemize}<apply-templates select = "Achievement[@lang = $lang]" />\end{itemize}</if>\end{itemize}}
  </template>
  <!--    <comment>\newline{}
      Key technologies and languages: <value-of select = 'Techs' /></comment>-->


<!--   <template match = '/Document/Skills'>\section{Skills}<apply-templates /></template>
  <template select = '/Document/Skills/Group[@lang = $lang]'>\subsection{<value-of select = '@type' />}<apply-templates /></template>
  <template match = '/Document/Skills//Entry'><choose><when test = '@type'>\cvline{<value-of select = '@type' />}</when><otherwise>\cvlistitem</otherwise></choose>{<value-of select = '.' />}</template>
   -->
  <template match = '/Document/Programs'>\section[\faTasks]{Pet projects}<apply-templates /></template>
  <template match = '/Document/Programs/Entry'>%
    <choose>
      <when test = '@type'>\cvline{<value-of select = '@type' />}</when>
      <otherwise>\cvlistitem</otherwise></choose>%
    {<value-of select = '.' /> %
      <if test="@href"> \url{<value-of select="@href" />} </if>%
    }%
  </template>
  
  <template match = '/Document/Portfolio/*'><apply-templates /></template>
  
  <template match = '/Document/Bibliography'>\begin{thebibliography}{9}
    <apply-templates />
  \end{thebibliography}</template>
  <template match = '/Document/Bibliography/Entry'>\bibitem{}
    \href{<value-of select = '@Url' />}{<value-of select = '@Title' />}. <value-of select = '@Url' />, <value-of select = '@Year' />
  </template>
  <xsl:include href="resume.tex.header.xsl" />
</stylesheet>