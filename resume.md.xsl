<?xml version="1.0"?>
<!DOCTYPE stylesheet [
  <!ENTITY mdash "&#8212;">
]>
<stylesheet xmlns:xlink = "http://www.w3.org/1999/xlink" version = "1.0"
            xmlns="http://www.w3.org/1999/XSL/Transform"
>
  <output method = "text" media-type = "plain/txt" />
    <param name="lang">en</param>
  <!-- [Link text Here](https://link-url-here.org) -->
  <template match = "*[ @xlink:role = 'locator' ]"><choose>
    <when test = 'text()'>[<value-of select = "." />](<value-of select = "@xlink:href" />)</when>
    <otherwise>[<value-of select = "@xlink:href" />](<value-of select = "@xlink:href" />)</otherwise></choose>
  </template>
  
  <template match = "/">
<apply-templates select = '/Document/Meta/Personal[@lang = $lang]' />
<apply-templates select = '/Document/Meta/following-sibling::*' />
  </template>
  
  <template match="Period"><value-of select = "@From" />-<value-of select = "@To" /></template>
  <!-- Meta -->
  <template match = '/Document/Meta'><apply-templates /></template>
  <template match = '/Document/Meta/Personal'># Personal
<apply-templates /></template>
  <template match = '//Meta/Title'><value-of select = '$lang' /> <value-of select = '.' /></template>
  <!-- TODO align -->
  <template match = '//Personal/FirstName'> <value-of select = '.' /> </template>
  <template match = '//Personal/FamilyName'> <value-of select = '.' /> </template>
  <template match = '//Personal/Address'>address: <value-of select = '.' /></template>
  <template match = '//Personal/Phone'><if test = '@type = "cell"'>cell:</if><value-of select = '.' /></template>
  <template match = '//Personal/Email'>email: <value-of select = '.' /></template>
  <template match = '//Personal/Extra[ @type = "skype" ]'>skype: <value-of select = '.' /></template>

  <template match = '/Document/*'>
# <value-of select = 'name()' />
<apply-templates /></template>
  
  <template match = '/Document/*/*'>
## <value-of select = 'name()' />
<apply-templates /></template>

  <template match = '//Entry'>
- <apply-templates />
</template>
  
  <template match = '//Education/Entry'><apply-templates select = 'Period' />, __<value-of select = 'Degree' />__,
      <value-of select = 'Institution' />, 
      <value-of select = 'City' />, 
      _<value-of select = 'Grade' />_,
      > <value-of select = 'Description' />.

  </template>

  <template match = '//Experience//Entry'><apply-templates select = 'Period' />   '''<value-of select = '@Job' />''', /<value-of select = 'Employer/Name' />/, <value-of select = 'Employer/City' />, <value-of select = 'Employer/Description' />
<apply-templates select = 'Description' />
<apply-templates select="Achievement[@lang='$lang']" />
<!--
    <span class = 'techs'>Key technologies and languages: <value-of select = 'Techs' /></td></tr>--></template>
    
  <template match = '//Achievement'> - <value-of select = '.' /></template>
    
  <template match = '//Languages'># Languages
<apply-templates />
  </template>
  <template match = '//Language'> - <value-of select = '@name' />: <value-of select = '@skill' />
  </template>
    
  <template match = '/Document/Skills'># Skills
<apply-templates />
  </template>

    <template match = '/Document/Skills/Group'>## <value-of select = '@type' />
<apply-templates />

    </template>

  <template match = '/Document/Skills//Entry'> - <choose>
        <when test = '@type'>
            <value-of select = '@type' />
        </when>
        <otherwise></otherwise>
    </choose> <value-of select = '.' />
  </template>
    
    <template match = '/Document/Bibliography'># Publications
        <apply-templates />

    </template>

    <template match = '/Document/Bibliography/Entry'> - <value-of select = '@Author' />, [<value-of select = '@Title' />](<value-of select = '@Url' />), <value-of select = '@Year' />
    </template>
  
</stylesheet>