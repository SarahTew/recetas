<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mtp="http://marktwainproject.org"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
     exclude-result-prefixes="xs mtp tei" version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>

    <xsl:param name="pPat">"</xsl:param>
    <xsl:param name="pRep">\\"</xsl:param>
    
    <xsl:template match="/">
            <xsl:call-template name="yaml-meta"/>
    </xsl:template>

    <xsl:template match="tei:TEI">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- teiHeader: do not process -->
    <xsl:template match="tei:teiHeader"/>
    
    <!-- text -->
    <xsl:template match="tei:text">
        <xsl:apply-templates/>
    </xsl:template>
    
    <!-- front: do not process -->
    <xsl:template match="tei:front"/> 
    
    <!-- body -->
    <xsl:template match="tei:body">
        <xsl:call-template name="yaml-meta"/>
    </xsl:template>
    
    <!--back: do not process-->
    <xsl:template match="tei:back"/>
    
    <xsl:template name="yaml-meta">  
        <xsl:text>---</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>layout: letter</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>identifier: "</xsl:text>
        <xsl:value-of select="normalize-space(/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1])"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>title: "</xsl:text>
        <xsl:call-template name="title"/>
        <xsl:text>"&#10;</xsl:text>
        <xsl:text>writer: </xsl:text>
        <xsl:text>[</xsl:text>
            <xsl:text>"</xsl:text>
        <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:author[1])))"/>
            <xsl:text>"</xsl:text>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>people: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:for-each-group select="//tei:persName" group-by="@n">
        <xsl:text>"</xsl:text>
            <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(current-grouping-key()))"/>
        <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each-group>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>places: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:for-each-group select="//tei:placeName" group-by="@n">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(current-grouping-key()))"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each-group>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>organizations: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:for-each-group select="//tei:orgName" group-by="@n">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(current-grouping-key()))"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each-group>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>references: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:for-each-group select="//tei:rs" group-by="@n">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(current-grouping-key()))"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each-group>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>addressee: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>rawDate: </xsl:text>
        <xsl:value-of select="replace(replace(replace(normalize-space(date), '0000', '2222'), '00-00', '12-31'),'-00', '-01')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>weight: </xsl:text>
        <xsl:value-of select="number(normalize-space(/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1]))"/>
        <xsl:text></xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>---</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>{{&lt; readFile file="./html/letters/</xsl:text><xsl:value-of select="normalize-space(/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1])"/><xsl:text>_letter.html"&gt;}}</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>{{&lt; readFile file="./html/notes/</xsl:text><xsl:value-of select="normalize-space(/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1])"/><xsl:text>_notes.html"&gt;}}</xsl:text>
    </xsl:template>

    <xsl:function name="mtp:mardownify" >
        <xsl:param name="inString"/>
        <xsl:value-of select="replace($inString,$pPat ,$pRep)"/>
    </xsl:function>

    <xsl:function name="mtp:trimTrailing" >
        <xsl:param name="inString"/>
        <xsl:value-of select="replace($inString, '(\.)\.?$' , '')"/>
    </xsl:function>
    
    <xsl:template name="title">
        <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(/tei:TEI/tei:teiHeader[1]/tei:fileDesc[1]/tei:titleStmt[1]/tei:title[1])))"/>
        <xsl:text>: </xsl:text>
        <xsl:choose>
            <xsl:when test="/tei:TEI/tei:teiHeader[1]/tei:profileDesc[1]/tei:correspDesc[1]/tei:correspAction[1][@type = 'sent']/tei:date[1]/@when castable as xs:date">
                <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(xs:string(/tei:TEI/tei:teiHeader[1]/tei:profileDesc[1]/tei:correspDesc[1]/tei:correspAction[1][@type = 'sent']/tei:date[1]/format-date(xs:date(@when), '[MNn] [D], [Y]', 'en', (), ()))))"/>
    </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(xs:string(/tei:TEI/tei:teiHeader[1]/tei:profileDesc[1]/tei:correspDesc[1]/tei:correspAction[1][@type = 'sent']/tei:date[1])))">
                  
                </xsl:value-of>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

</xsl:stylesheet>
