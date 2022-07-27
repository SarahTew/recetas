<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xs" version="2.0">
    <xsl:output encoding="UTF-8" method="html" doctype-system="about:legacy-compat"/>
    <xsl:template match="tei:TEI">
        <html> <head>
                <title>MTPO Doc Ed</title>
                <link rel="stylesheet" type="text/css" href="/css/doced.css"/>
            <link rel="stylesheet" type="text/css" href="/Users/blakebronsonbartlett/gitlab/mtp-doced/css/doced.css"/>
                 </head> <body>
                <xsl:apply-templates/>
                     <script src="../js/popup.js"/></body>
        </html> </xsl:template>
    <!-- teiHeader: do not process -->
    <xsl:template match="tei:teiHeader"/>
    <!-- text -->
    <xsl:template match="tei:text">
        <xsl:call-template name="toc"/>
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- front -->
    <xsl:template match="tei:front"> 
        <xsl:apply-templates/>
        <xsl:call-template name="endnotes"/>
    </xsl:template>
    
    <!-- body -->
    <xsl:template match="tei:body">
        <xsl:apply-templates/>
        <xsl:call-template name="endnotes"/>
    </xsl:template>
    
    <!--back [endnotes added to accommodate annotated back matter (i.e. Ashcroft-Lyon MS)]-->
    <xsl:template match="tei:back">
        <xsl:apply-templates/>
        <xsl:call-template name="endnotes"/>
    </xsl:template>

    <!-- divs -->
    <xsl:template match="tei:div">
        <div>
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <!-- numbered divs -->
    <xsl:template match="tei:div1 | tei:div2 | tei:div3 | tei:div4">
        <div>
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    

    <xsl:template match="tei:div[@type]" priority=".5">
        <div class="{@type}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- p with if test to allow markup styling-->
    <xsl:template match="tei:p">
        <p>
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!--p with hanging indent 1-->
    
    <xsl:template match="tei:p[@rend='hangbib1']">
        <p style="text-indent:-3em; padding-left:3em;">
            
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!--p with hanging indent 2-->
    
    <xsl:template match="tei:p[@rend='hangbib2']">
        <p style="text-indent:-3em; padding-left:5em;">
            
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- -p with no indent -->
    
    <xsl:template match="tei:p[@rend='text-indent:2']">
        <p style="text-indent:2em;">
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <xsl:template match="tei:p[@rend='noindent']">
        <p style="text-indent:0em;">
            
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- -p with no indent -->
    
    <xsl:template match="tei:p[@rend='center']">
        <p style="text-align:center;">
            
            <xsl:apply-templates/>
        </p>
    </xsl:template>
    
    <!-- -p with @rend right -->
    
    <xsl:template match="tei:p[@rend='right']">
        <p style="text-align:right;">
            
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- ab -->
    <xsl:template match="tei:ab">
        <div class="ab">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:ab[@type='caption']">
        <div class="ab" style="font-size:smaller; background-color:transparent;">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--<xsl:template match="tei:ab[@type='withMarginNote']">
        <div class="ab" style="float:left; background-color:transparent; text-align:left">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='margin']">
        <div class="metamark" style="float:right;padding-left:30px;max-width:100px;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>-->
    
    <!-- do not display transcription of image-->
    <xsl:template match="tei:ab[@type='transcript']">
        
    </xsl:template>
    
    <!--floatingText (currently duplicates ab transformation)-->
    
    <xsl:template match="tei:floatingText">
        <div class="ab">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--head-->
    <xsl:template match="tei:head">
        <div class="head">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--head with @type "sum" for summary subheadings in autobiographical dictations-->
    
    <xsl:template match="tei:head[@type='sum']">
        <div class="head" style="font-size:14pt;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- lb -->
    <xsl:template match="tei:lb">
        <br/>
        <!--<span class="lb">
            <xsl:value-of select="@n"/><xsl:text>&#160;</xsl:text>
        </span>-->
    </xsl:template>


    <!-- editorial tags: spans with class; style with css -->
    <xsl:template match="tei:add | tei:del | tei:unclear | tei:seg | tei:metamark | tei:dateline | tei:sourceline | tei:salute | tei:closer | tei:signed | tei:postscript | tei:name | tei:date | tei:ref | tei:opener | tei:corr | tei:anchor | tei:lg  | tei:list | tei:figDesc | tei:address | tei:metamark">
        <span class="{local-name()}">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--milestone; select @rend, style in css-->
    
    <xsl:template match="tei:milestone">
        <span>
            <hr>
            <xsl:attribute name="class">
                <xsl:value-of select="@rend"/>
            </xsl:attribute>
            </hr>
                <xsl:apply-templates/> 
            </span>   
    </xsl:template>
    
    <!--milestone for textual lacunae (i.e., [. . . .])-->
    
    <xsl:template match="tei:milestone[@rend = 'lacuna']">
        
            <span class="milestone">
                <metamark>
                <xsl:apply-templates select="@n"/> 
                </metamark>
            </span>   
        
    </xsl:template>
    

    <!-- choice; contains reg and orig below-->
    <xsl:template match="tei:choice">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- reg: do not display -->
    <xsl:template match="tei:reg"> 
    </xsl:template>
    <!-- orig: display-->
    <xsl:template match="tei:orig">
        <xsl:apply-templates/>
    </xsl:template>

    <!-- pb; select @facs image; select @n; added "begin page" text; @style allows styling in markup-->
    <xsl:template match="tei:pb">
        <p>
            <span class="pb"  style="{@style}">
            <xsl:apply-templates select="@facs"/>
            <br/>
            <xsl:text> [begin page </xsl:text> <xsl:value-of select="@n"/><xsl:text>] </xsl:text>
        </span>
        </p>
    </xsl:template>
    
    <!--table transformed into table html element; added if test for @rend-->
    
    <xsl:template match="tei:table">
        <table>
            <xsl:if test="@rend">
                <xsl:attribute name="class">
                    <xsl:value-of select="@rend"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:choose>
                <xsl:when test="@border"/>
                <xsl:otherwise>
                    <xsl:attribute name="border">1</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
            <xsl:apply-templates/>
            <xsl:if test="normalize-space(.)">
                <xsl:text> </xsl:text>
            </xsl:if>
            
        </table>
         
    </xsl:template> 
    
    <!--row changed to transform into tr element in html-->
    
    <xsl:template match="tei:row">
        <tr>
            <xsl:if test="@rend">
                <xsl:attribute name="class">
                    <xsl:value-of select="@rend"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </tr>
        
    </xsl:template>
    
    <!--cell changed to transform into td element in html -->
    
    <xsl:template match="tei:cell">
        <td>
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </td>
        
    </xsl:template>
    
    
    <!--insert line break after item in list-->
    
    <xsl:template match="tei:item">
            <span class="item">
                <xsl:apply-templates/>
            </span><br/>
    </xsl:template>
    
    
    <!--insert space after label before item in list-->
    <xsl:template match="tei:label">
        <span class="label">
            <xsl:apply-templates/>
        </span>&#160;&#160;
    </xsl:template>

    <!--pb; grab value of @facs; produce thumbnail (style thumb in css); modal-->
    <xsl:template match="tei:pb/@facs">        
        <a class="popup" href="{.}" onClick="window.open(this.href, this.target,&#xA;'scrollbars=yes,width=550,height=700'); return(false);">
            <img id="myImg" src="{.}" class="thumb"/>
        </a>
       
        <!--The Modal; style in css-->
        <!--
        <div id="myModal" class="modal">
            
            //The Modal Close Button
            <span class="close">X</span>
            
            //Modal Content (The Image)
            <img class="modal-content" id="img01"></img>
                
                //Modal Caption (Image Text)
                <div id="caption"></div>
        </div>
        -->
        
    </xsl:template>
    
    
    <!--figure; select @facs; allow figDesc inside figure, style figDesc in css-->
    <xsl:template match="tei:figure">        
        <span class="figure">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="@facs"/>
            <span class="figDesc"><xsl:apply-templates/></span>
        </span>
    </xsl:template>
    
    <!--figure; select @facs; display as image; style "img" in css-->
    <xsl:template match="tei:figure/@facs">       
        <img id="myImg" src="{.}"/>       
    </xsl:template>
    
    <!--graphic (duplicates both figure templates above)-->
    
    <xsl:template match="tei:graphic">
        <span class="figure">
            <xsl:apply-templates select="@facs"/>
            <span class="figDesc"><xsl:apply-templates/></span>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:graphic/@facs">       
        <img id="myImg" src="{.}"/>       
    </xsl:template>

    <!--fw; style in markup-->
    <xsl:template match="tei:fw">
        <div class="fw" style="{@style}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--hi @rend templates-->
    <xsl:template match="tei:hi[@rend = 'italic']">
        <span class="hi" style="font-style:italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'bold']">
        <span class="hi" style="font-weight:bold;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'underline']">
        <span class="hi" style="text-decoration:underline;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'superscript']">
        <span class="hi" style="vertical-align: super; font-size: 10px;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'subscript']">
        <span class="hi" style="vertical-align: sub; font-size: 10px;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'smallcaps']">
        <span class="hi" style="font-variant:small-caps;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'xs-smallcaps']">
        <span class="hi" style="font-variant:small-caps; font-size: smaller;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'normal']">
        <span class="hi" style="font-style:normal;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'dot-underline']">
        <span class="hi" style="text-decoration-line: underline; text-decoration-style: dotted;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'dbul']">
        <span class="hi" style="text-decoration-line: underline; text-decoration-style: double;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <xsl:template match="tei:hi[@rend = 'shaded']">
        <span class="hi" style="background-color: lightgrey;">  
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--hi @rend default-->
    <xsl:template match="tei:hi"> 
        <span class="hi-{@rend}">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!--quote; no longer uses css in the xslt to style @rend "blockquote"; style moved to doced.css; (style for pb inside quote is in css)-->
    
    <xsl:template match="tei:quote[@rend='blockquote']">
        <div class="quote">
            
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--grid for paragraphs with margin notes, primarily for autobiography-->
    
    <!-- create template for note with @place "rightMargin" (use @mode "margin" to create distinction for display in div "item2" only-->
    
    <xsl:template match="tei:note[@place = 'rightMargin']" mode = 'margin'>
        <span class="rightMargin">
            <xsl:apply-templates/>
        </span>
    </xsl:template>
    
    <!-- do not display note inside of p (use @mode in template below)-->
    
    <xsl:template match="tei:note[@place = 'rightMargin']">

    </xsl:template>
    
    <!-- any p element with note @place "rightMargin" creates a grid-container div with two grid boxes inside of it (div @class "item1" and "item2", both styled in css); apply template for note @place "rightMargin" with @mode (from template above) to make it display inside div "item2" but not in div "item1"-->
    
    <xsl:template match="tei:p[child::tei:note[@place = 'rightMargin']]">
        <div class="grid-container">
            <div class="item1">
               <p class="main">
                   <xsl:if test="@style">
                       <xsl:attribute name="style">
                           <xsl:value-of select="@style"/>
                       </xsl:attribute>
                   </xsl:if>
                   <xsl:apply-templates/>
               </p>
            </div>
            <div class="item2">
                <xsl:apply-templates select="descendant::tei:note[@place = 'rightMargin']" mode= "margin"/>                
            </div>
           
        </div>
    </xsl:template>
    
   
    
    <!--grid-->
    
    <xsl:template match="tei:metamark[@function='marginNote']">
        <div class="grid-container">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='topLeftMargin']">
        <div class="item1">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='topCenterMargin']">
        <div class="item2">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='topRightMargin']">
        <div class="item3">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='leftMargin']">
        <div class="item4">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='main']">
        <div class="item5">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='rightMargin']">
        <div class="item6">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='bottomLeftMargin']">
        <div class="item7">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='bottomCenterMargin']">
        <div class="item8">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <xsl:template match="tei:metamark[@place='bottomRightMargin']">
        <div class="item9">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--l-->
    
    <xsl:template match="tei:l">
        <span class="l">
            <xsl:if test="@style">
                <xsl:attribute name="style">
                    <xsl:value-of select="@style"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/><br/>
        </span>       
    </xsl:template>
    
    <!-- ELEMENT: space; appropriated and modified from MTPcommon -->
    <xsl:template match="tei:space">
        <xsl:apply-templates/>
        <xsl:for-each select="1 to @extent">
            <xsl:text>&#12288;</xsl:text>
        </xsl:for-each>
    </xsl:template>
    
<!--head with @rend = "toc" for table of contents in the xml: use xml:id and corresp to link back and forth between heads in toc list at top of document and heads at the top of relevant divs in multi-div documents; this xslt was originally made to deal with appendixes in the Autobiography, so that we didn't have to break the multiple appendixes into individual XML documents. -->
    
    <xsl:template match="tei:head[@rend = 'toc']">
        <ul class="toc">
            <a name="{@xml:id}" href="{@corresp}">
                <xsl:apply-templates/>
            </a>
        </ul>
        
    </xsl:template>
    
    
    <xsl:template match="tei:div1/tei:head[@rend = 'toc']">
        <ul class="toc">
            <a name="{ancestor::tei:div1/@xml:id}" href="#t-{ancestor::tei:div1/@xml:id}">
                <xsl:apply-templates/>
            </a>
        </ul>
        
    </xsl:template>
    
    
    <!--note-->
    <!-- note: do not display -->
    <!-- link from text -->
    <xsl:template match="tei:note">
        <a href="#e-{@xml:id}" name="r-{@xml:id}"><span class="note-ref"><xsl:value-of select="@n"/></span></a>
    </xsl:template>
    
    <!-- note: do not display any with place=foot-->
    <!-- at higher priority than type=ed below     -->
    <xsl:template match="tei:note[@place = 'foot']"  priority=".6">
        <a href="#e-{@xml:id}" name="r-{@xml:id}"><span class="note-ref"><xsl:value-of select="@n"/></span></a>
    </xsl:template>
    
    <xsl:template match="tei:ptr">
        <a href="#e-{translate(@target, '#', '')}" name="r-{@xml:id}"><span class="note-ref"><xsl:value-of select="@type"/></span></a>
    </xsl:template>
    
    <!--reinstating app-->
    <xsl:template match="tei:app">
        <a href="#e-{@xml:id}" name="r-{@xml:id}"><span class="note-ref"><xsl:value-of select="@n"/></span></a>
    </xsl:template>
    
    
    <!--display editorial notes (note @type "ed") in text:style in css-->
    <xsl:template match="tei:note[@place = 'inline'][@type = 'ed']" priority=".9">
        <span class="note-inline-ed"><xsl:apply-templates/></span>        
    </xsl:template>
    
    <!--display authorial insertions as notes (note @type "au") in text:style in css-->
    <xsl:template match="tei:note[@place = 'inline'][@type = 'au']" priority=".8">
        <span class="note-inline-au"><xsl:apply-templates/></span>        
    </xsl:template>

    <!--display editorial notes in text (note @type "ed"); insert brackets before and after; style brackets in css to override italics-->
    <xsl:template match="tei:note[@type = 'ed']" priority=".5">
        <span class="note-inline"><xsl:text>[</xsl:text><xsl:apply-templates/><xsl:text>]</xsl:text></span>        
    </xsl:template>
    
    <!--This note @type is obsolete, but we need it for revision. Display @n value of note @type "pt" (post-transmission); the styling of square brackets carries over from "note-inline" above; this note element does not wrap text-->
    
    <xsl:template match="tei:note[@place = 'inline'][@type = 'pt']" priority=".6">
        <span class="note-inline"><xsl:text>[</xsl:text><xsl:value-of select="@n"/><xsl:apply-templates/><xsl:text>]</xsl:text></span>        
    </xsl:template>

<!-- End Notes, or divs inside "commentary" divs; style in css -->
    
    <xsl:template name="endnotes">
        
    <!--insert head for and compile list of editorial notes (@type "ed") with @place "foot." These are for introductions to the critical editions.-->   
        <xsl:if test=".//tei:note[@place = 'foot'][@type = 'ed']">
            <div class="endnotes">
                <div class="head">Editorial Notes</div>
                <xsl:apply-templates select=".//tei:note[@place = 'foot'][@type = 'ed']" mode="endnotes"/>
            </div>
        </xsl:if>
    
        
        <!--insert head for and compile list of explanatory notes (@type "an")-->
    <xsl:if test=".//tei:note[@type = 'an']">
    <div class="endnotes">
        <div class="head">Explanatory Notes</div>
        <xsl:apply-templates select=".//tei:note[@type = 'an']" mode="endnotes"/>
    </div>
    </xsl:if>
    
    
    <!--see "reinstated app" below...
        
    <xsl:if test=".//tei:note[@type = 'te']">
    <div class="endnotes">
        <div class="head">Textual Notes</div>
        <xsl:apply-templates select=".//tei:note[@type = 'te']" mode="endnotes"/>     
    </div>         
    </xsl:if>
    -->
        
        <!--reinstated app element for textual notes: insert head for and compile list of textual notes (@type "te"); see "Apparatus" section below for linking and lem/rdg processing-->
        <xsl:if test=".//tei:app[@type = 'te']">
            <div class="endnotes">
                <div class="head">Textual Notes</div>
                <xsl:apply-templates select=".//tei:app[@type = 'te']" mode="endnotes"/>     
            </div>         
        </xsl:if>

    <!--insert head for and compile list of alterations in manuscript (@type "alt")-->
    <xsl:if test=".//tei:note[@type = 'alt']">
        <div class="endnotes">
            <div class="head">Alterations in the Manuscript</div>
            <xsl:apply-templates select=".//tei:note[@type = 'alt']" mode="endnotes"/>
        </div>
    </xsl:if>
        
        <!--insert head for and compile list of emendations (@type "em")-->
        <xsl:if test=".//tei:note[@type = 'em']">
            <div class="endnotes">
                <div class="head">Editorial Emendations</div>
                <xsl:apply-templates select=".//tei:note[@type = 'em']" mode="endnotes"/>
            </div>
        </xsl:if> 
                
    </xsl:template>

    <!--for div @type endnotes in critical editions: lists of endnotes that are already compiled in critical editions.-->
    
    <xsl:template match="tei:div[@type = 'endnotes']" priority=".9">
        <div class="endnotes">
            <xsl:apply-templates select="tei:head"/>
            <xsl:if test=".//tei:note"><xsl:apply-templates select="tei:note" mode="endnotes"/></xsl:if>
            <xsl:if test="not(.//tei:note)"><xsl:text>None for this chapter.</xsl:text></xsl:if>
            
        </div>
        
    </xsl:template>
    
    <!--for ptr in critical editions: if a note is pointed to by a ptr element, then link back to ptr in text using @targetEnd. Take note that div @class "endnote" is used here to render the list of endnotes appropriately; the behavior differs from div @class "endnotes" (the difference is in the plural), which inserts extra space between individual notes in a list.-->
    <xsl:template match="tei:note[concat('#', @xml:id) = preceding::tei:ptr/@target]" mode="endnotes" priority=".9">      
        <div class="endnote">
            <a name="e-{@xml:id}" href="#r-{translate(@targetEnd, '#', '')}"><span class="note-ref"><xsl:value-of select="@type"/></span></a><xsl:text>&#160;</xsl:text><xsl:apply-templates/>
        </div>
        
    </xsl:template>
    
    <!--for letters and documentary editions without precompiled lists of endnotes, as well as inline note elements in critical editions (i.e., "editorial emendations" or note @type "em"), link endnotes from body of text to compiled list and from list to body. Take note that div @class "endnote" is used here to render the list of endnotes appropriately; the behavior differs from div @class "endnotes" (the difference is in the plural), which inserts extra space between individual notes in a list.-->
    <xsl:template match="tei:note" mode="endnotes" priority=".5">
        <div class="endnote">
            <a name="e-{@xml:id}" href="#r-{@xml:id}"><span class="note-ref"><xsl:value-of select="@type"/></span></a><xsl:text>&#160;</xsl:text><xsl:apply-templates/>
        </div>
    </xsl:template>
       
       
    
    <!-- Apparatus -->

    <!--reinstated app-->
    <xsl:template match="tei:app" mode="endnotes" priority=".5">
        <div class="endnote">
            <a name="e-{@xml:id}" href="#r-{@xml:id}"><span class="note-ref"><xsl:value-of select="@type"/></span></a><xsl:text>&#160;</xsl:text><xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--insert bullet point and spacing between lem and rdg elements; if lem or rdg has @wit, place value of @wit between brackets (style in css)-->
    <xsl:template match="tei:lem">     
        <xsl:apply-templates/>
        <xsl:if test="@wit">
            <xsl:text>&#160;(</xsl:text><xsl:value-of select="@wit"/><xsl:text>)&#160;</xsl:text>
        </xsl:if>
        <xsl:text>&#160;•&#160;</xsl:text>
    </xsl:template>
    
    <xsl:template match="tei:rdg">
        <xsl:apply-templates/>
        <xsl:if test="@wit">
            <xsl:text>&#160;(</xsl:text><xsl:value-of select="@wit"/><xsl:text>)&#160;</xsl:text>
        </xsl:if>
    </xsl:template>
    
    
    
    <!--<xsl:template match="tei:note[parent::tei:rdg]">
        <xsl:text>[</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>]</xsl:text>
    </xsl:template>-->
    
    <!--default that tells us what elements are not defined in this document-->
    <xsl:template match="tei:*">
        <xsl:message><xsl:text>unknown element: </xsl:text><xsl:value-of select="local-name()"/></xsl:message>
    </xsl:template>

<xsl:template name="toc">
    <xsl:apply-templates select="//tei:div1/tei:head[@rend = 'toc']" mode="toc"/>
<hr/>

</xsl:template>
    
<xsl:template match="tei:head[@rend = 'toc']" mode="toc">
    <p class="toc"><a name="t-{ancestor::tei:div1/@xml:id}" href="#{ancestor::tei:div1/@xml:id}"><xsl:value-of select="."/></a></p>
</xsl:template>    


</xsl:stylesheet>
