<?xml version="1.0"?>
<!DOCTYPE stylesheet [
  <!ENTITY mdash "&#8212;">
]>
<stylesheet xmlns:xlink = "http://www.w3.org/1999/xlink" version = "1.0"
            xmlns="http://www.w3.org/1999/XSL/Transform"
>
    <output method = "text" media-type = "plain/txt" />
    <param name="lang">en</param>
  <!-- collapse any text as markdown is very sensible to whitespace -->
  <template match="//Meta/Personal/text()" />
  <template match="//Cloud" />
  <template match="comment()" />
  <!-- [Link text Here](https://link-url-here.org) -->
  <template match = "*[ @xlink:role = 'locator' ]"><!-- every symbol inside template goes to markdown,
        which is very sensible to whitespaces, so watchout! --><choose>
    <when test = 'text()'>[<value-of select = "." />](<value-of select = "@xlink:href" />)</when>
    <otherwise>[<value-of select = "@xlink:href" />](<value-of select = "@xlink:href" />)</otherwise>
  </choose><!--
  --></template>

  <template match = "/">
<apply-templates select = '/Document/Meta' />
<apply-templates select = '/Document/Meta/following-sibling::*' />
  </template>

  <template match="Period">`<value-of select = "@From" /> -- <value-of select = "@To" />`</template>
  <!-- Meta -->
  <template match = '//Meta'><apply-templates select="*[not(@lang) or @lang=$lang]"/></template>
  <template match = '//Meta/Title' priority="1">
# <value-of select = '.' /><!--
    --></template>

  <template match = '//Meta/Personal'>
<apply-templates /></template>

  <!-- TODO align -->
    <template match='//Personal/FirstName' priority="1" />
    <template match='//Personal/FamilyName' priority="1" />
    <template match='//Personal/Photo' priority="1" />
    <template match='//Personal/Phone' priority="1" />
    <template match='//Personal/Telegram' priority="1" >
 - _<value-of select="name()"/>_: **[<value-of select = '.' />](https://t.me/<value-of select = '.' />)**</template>
    <template match='//Personal/LinkedIn' priority="1" >
 - _<value-of select="name()"/>_: **[<value-of select = '.' />](https://www.linkedin.com/in/<value-of select = '.' />)**</template>
    <template match = '//Personal/*'>
 - _<value-of select="name()"/>_: **<value-of select = '.' />**</template>


  <template match = '/Document/*'>
# <value-of select = 'name()' />
<apply-templates select="*[not(@lang) or @lang=$lang]"/></template>

  <template match = '//Group/text()' />
  <template match = '/Document/*/*'>
### <choose>
    <when test="@type"><value-of select = '@type' /></when>
    <otherwise><value-of select = 'name()' /></otherwise>
  </choose>
<apply-templates select="*[not(@lang) or @lang=$lang]"/></template>

  <template match = '//Entry'>
 - <apply-templates /></template>

  <template match = '//Education/Entry'>
 - <apply-templates select = 'Period' />, __<value-of select = 'Degree' />__,
      <value-of select = 'Institution' />,
      <value-of select = 'City' />,
      _<value-of select = 'Grade' />_,
      > <value-of select = 'Description' />.

  </template>

  <template match = '//Experience//Entry' priority="1">
 - <apply-templates select = 'Period' /> __<value-of select = 'Job[not(@lang) or $lang=@lang]' />__, /_<value-of select = 'Employer/Name' />_/, <value-of select = 'Employer/City' />, <value-of select = 'Employer/Description' />
<apply-templates select = 'Description[not(@lang) or $lang=@lang]' /><!-- new line comment
--><apply-templates select="Achievement[@lang=$lang]" /></template>

  <template match = '//Achievement'>
   - <value-of select = '.' /></template>

  <template match = '//Language'>
- <value-of select = '@name' />: <value-of select = '@skill' /></template>

  <template match = '/Document/Skills//Entry'>
- <choose>
        <when test = '@type'>**<value-of select = '@type' />**: </when>
        <otherwise></otherwise>
  </choose> <value-of select = '.' /></template>

    <template match = '/Document/Bibliography'>
# Publications
        <apply-templates />

    </template>

    <template match = '/Document/Bibliography/Entry'> - <value-of select = '@Author' />, [<value-of select = '@Title' />](<value-of select = '@Url' />), <value-of select = '@Year' />
    </template>

  <template match = '//Programs/Entry'>
 - <choose>
    <when test="@href">[<value-of select = '@type' />](<value-of select="@href" />)</when>
    <otherwise><value-of select = '@type' /></otherwise>
  </choose>: <value-of select = '.' /></template>
</stylesheet>