<?xml version="1.0"?>
<!DOCTYPE stylesheet [
  <!ENTITY mdash "&#8212;">
]>
<xsl:stylesheet xmlns:xsl = "http://www.w3.org/1999/XSL/Transform" xmlns:xlink = "http://www.w3.org/1999/xlink" version = "1.0">
  <xsl:output method = "html" media-type = "application/xhtml+xml" />
  <xsl:param name = "lang" >en</xsl:param>
  <xsl:template match = "*[ @xlink:role = 'locator' ]">
    <a>
      <xsl:attribute name = 'href'><xsl:value-of select = "@xlink:href" /></xsl:attribute>
      <xsl:choose>
        <xsl:when test = 'text()'><xsl:value-of select = "." /></xsl:when>
        <xsl:otherwise><xsl:value-of select = "@xlink:href" /></xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>
  
  <xsl:template match = "/">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html&gt;</xsl:text>
<html lang="en">
  <head> 
    <xsl:apply-templates select = '/Document/Meta/Title' />
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="description" content="Andrey Zakharov's CV" />
    <meta name="author" content="Andrey Zakharov" />
        <!-- Bootstrap Core CSS -->
    <link href="assets/startbootstrap-freelancer/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet" />

    <!-- Theme CSS -->
    <link href="assets/startbootstrap-freelancer/css/freelancer.min.css" rel="stylesheet" />

    <!-- Custom Fonts -->
    <link href="assets/startbootstrap-freelancer/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css" />
    <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css" />

    <link href="assets/cv.css" rel="stylesheet" />

  </head>
  <body id="page-top" class="index">
        <!-- Navigation -->
    <nav id="mainNav" class="navbar navbar-default navbar-fixed-top navbar-custom">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand" href="#page-top"><xsl:value-of select = '/Document/Meta/Title' /></a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
                    <li class="page-scroll">
                        <a href="#Experience">Experience</a>
                    </li>
                    <li class="page-scroll">
                        <a href="#about">About</a>
                    </li>
                    <li class="page-scroll">
                        <a href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

  	<xsl:apply-templates select = '/Document/Meta' />
  	<xsl:apply-templates select = '/Document/Meta/following-sibling::*' />

    <script src="assets/js/modernizr.js"></script>
        <!-- jQuery -->
    <script src="assets/startbootstrap-freelancer/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="assets/startbootstrap-freelancer/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Plugin JavaScript -->
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>

    <!-- Contact Form JavaScript -->
    <!-- <script src="assets/startbootstrap-freelancer/js/jqBootstrapValidation.js"></script> -->
    <!-- <script src="assets/startbootstrap-freelancer/js/contact_me.js"></script> -->

    <!-- Theme JavaScript -->
    <script src="assets/startbootstrap-freelancer/js/freelancer.min.js"></script>
    <script src="assets/js/timeline.js"></script>

  </body>
</html>
  </xsl:template>
  
  <xsl:template match="Period"><xsl:value-of select = "@From" />&mdash;<xsl:value-of select = "@To" /></xsl:template>
  <!-- Meta -->
  <xsl:template match = '/Document/Meta'><xsl:apply-templates select = "*[@lang=$lang]"/></xsl:template>
  <xsl:template match = '/Document/Meta/Personal'>    <!-- Header -->
    <header>
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    
                    <div class="intro-text">
                        <xsl:apply-templates select="Photo"/>
                        <span class="name"><xsl:value-of select = '/Document/Meta/Title' /></span>
                        <hr class="star-light" />
                        <xsl:apply-templates select="Skills"/>
                    </div>
                </div>
            </div>
        </div>
    </header>
  </xsl:template>
  
  <xsl:template match = '//Meta/Title'><title><xsl:value-of select = '.' /></title></xsl:template>
  
  <xsl:template match = '//Personal/FirstName'><span class='firstname'><xsl:value-of select = '.' /></span></xsl:template>
  <xsl:template match = '//Personal/FamilyName'><span class='familyname'><xsl:value-of select = '.' /></span></xsl:template>
  <xsl:template match = '//Personal/Address'><span class='address'><xsl:value-of select = '.' /></span></xsl:template>
  <xsl:template match = '//Personal/Phone'>
    <span class='phone'>
      <xsl:if test = '@type = "cell"'>
        <xsl:attribute name = 'class'>mobile</xsl:attribute>
      </xsl:if>
      <xsl:value-of select = '.' />
    </span>
  </xsl:template>
    
  <xsl:template match = '//Personal/Email'><span class='email'><a>
    <xsl:attribute name='href'>mailto:<xsl:value-of select = '.' /></xsl:attribute>
    <xsl:value-of select = '.' /></a></span></xsl:template>
  <xsl:template match = '//Personal/Extra[ @type = "skype" ]'><span class='skype'>skype: <xsl:value-of select = '.' /></span></xsl:template>
    
  <xsl:template match = '//Personal/Photo'>
    <img class="img-responsive clip-circle">
      <!--xsl:attribute name = 'width'>
        <xsl:value-of select = '@width' />
      </xsl:attribute-->
      <xsl:attribute name = 'src'>
        <xsl:value-of select = '.' />
      </xsl:attribute>
   </img>
  </xsl:template>

  <xsl:template match = '//Personal/Skills'><span class="skills"><xsl:value-of select = '.' /></span></xsl:template>
  
  <xsl:template match = '/Document/*'>
    <section>
      <xsl:attribute name = 'id'>
          <xsl:value-of select = 'name()' />
      </xsl:attribute>
      <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2><xsl:value-of select = 'name()' /></h2>
                <hr class="star-primary" />
            </div>
        </div>
        <xsl:apply-templates />
      </div>
    </section>
  </xsl:template>

  <xsl:template match = '/Document/Experience/Vocational'>
    <section id="experience-timeline" class="cd-container">
      <xsl:apply-templates />
    </section>
  </xsl:template>

  <xsl:template match = '//Vocational/Entry'> 
    <div class="cd-timeline-block">
      <div class="cd-timeline-img">
        <img alt="Picture">
          <xsl:attribute name="src">assets/img/<xsl:value-of select = 'Employer/Logo' /></xsl:attribute>
        </img>
      </div> <!-- cd-timeline-img -->
   
      <div class="cd-timeline-content">
        <h3><xsl:value-of select = '@Job' /></h3>
        <xsl:value-of select = 'Employer/Name' />, <xsl:value-of select = 'Employer/City' />, 
        <em><xsl:value-of select = 'Employer/Description' /></em>
        <p><xsl:apply-templates select = 'Description' /></p>
        <!--a href="#0" class="cd-read-more">Read more</a-->
        <span class="cd-date period"><xsl:apply-templates select = 'Period' /></span>
        <xsl:apply-templates select="Achievement[@lang='en']" /><br/>
        <span class = 'techs'>Key technologies and languages: <xsl:value-of select = 'Techs' /></span>
      </div> <!-- cd-timeline-content -->
    </div> <!-- cd-timeline-block -->
  </xsl:template>

  <xsl:template match = '/Document/*/*'><h2><xsl:value-of select = 'name()' /></h2>
    <table class = 'subsection'>
      <xsl:apply-templates />
    </table>
  </xsl:template>
  <xsl:template match = '/Document/Programs'></xsl:template>
  <xsl:template match = '/Document/Objective'></xsl:template>

  <xsl:template match = '/Document/Strengths'>    
    <section>
      <xsl:attribute name = 'id'>
          <xsl:value-of select = 'name()' />
      </xsl:attribute>
      <div class="container">
        <div class="row">
            <div class="col-lg-12 text-center">
                <h2><xsl:value-of select = 'name()' /></h2>
                <hr class="star-primary" />
            </div>
        </div>
        <ul>
          <xsl:apply-templates />
        </ul>
      </div>
    </section>
  </xsl:template>

  <xsl:template match = '//Strengths/Entry'><li><xsl:apply-templates /></li></xsl:template>
  
  <xsl:template match = '//Education/Entry'>
    <xsl:apply-templates select = 'Period' />, <strong><xsl:value-of select = 'Degree' /></strong>,
      <xsl:value-of select = 'Institution' />, 
      <xsl:value-of select = 'City' />, 
      <em><xsl:value-of select = 'Grade' /></em>, 
      <small><xsl:value-of select = 'Description' /></small>.<br />
  </xsl:template>

  <xsl:template match = '//Education/Thesis'>
<h2>Master thesis</h2>
<table class = 'subsection'>
  <tr><td>title</td><td><em><xsl:value-of select = 'Title' /></em></td></tr>
  <tr><td>supervisors</td><td><xsl:value-of select = 'Supervisors' /></td></tr>
  <tr><td>description</td><td><small><xsl:value-of select = 'Description' />}</small></td></tr>
</table>
  </xsl:template>

    
  <xsl:template match = '//Achievement'><li><xsl:value-of select = '.' /></li></xsl:template>
    
  <xsl:template match = '//Languages'><h1>Languages</h1><table class = 'languages'><xsl:apply-templates /></table></xsl:template>
  <xsl:template match = '//Language'><tr><td class='name'><xsl:value-of select = '@name' /></td>
  	<td class='skill'><xsl:value-of select = '@skill' /></td><td><xsl:value-of select = '.' /></td></tr></xsl:template>
    
  <xsl:template match = '/Document/Skills'><h1>Computer skills</h1><xsl:apply-templates /></xsl:template>
    <xsl:template match = '/Document/Skills/Group'><h2><xsl:value-of select = '@type' /></h2>
    <table class = 'subsection'>
    <xsl:apply-templates />
    </table>
    </xsl:template>

  <xsl:template match = '/Document/Skills//Entry'><tr>
    <xsl:choose>
        <xsl:when test = '@type'>
            <td class = 'type'><xsl:value-of select = '@type' /></td>
        </xsl:when>
        <xsl:otherwise></xsl:otherwise>
    </xsl:choose>
    <td class='entry'><xsl:value-of select = '.' /></td></tr></xsl:template>
    
  <xsl:template match = '/Document/Bibliography'><h1>Publications</h1>
      <table cellpadding = "1" cellspacing = "0" border = "0">
        <xsl:apply-templates />
  </table></xsl:template>

  <xsl:template match = '/Document/Bibliography/Entry'>
    <tr>
      <td><xsl:value-of select = '@Author' />, </td>
      <td>
        <a><xsl:attribute name = "href"><xsl:value-of select = '@Url' /></xsl:attribute><xsl:value-of select = '@Title' /></a>, 
      </td>
      <td><xsl:value-of select = '@Year' /></td>
    </tr>
  </xsl:template>

  <xsl:template match = '/Document/Links/Profiles'><ul class = "ProfileLinks"><xsl:apply-templates /></ul></xsl:template>
  <xsl:template match = '/Document/Links/Profiles/Entry'>
    <li>
      <a>
        <xsl:attribute name = "href">
          <xsl:value-of select = '@xlink:href' />
        </xsl:attribute>
        <strong><xsl:value-of select = '@type' /></strong>
        [
          <xsl:value-of select="@xlink:href" />
        ]
      </a>
    </li>
  </xsl:template>


  
</xsl:stylesheet>