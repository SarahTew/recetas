<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:mtp="http://marktwainproject.org"
     exclude-result-prefixes="xs mtp" version="2.0">
    <xsl:output encoding="UTF-8" method="text"/>

    <xsl:param name="pPat">"</xsl:param>
    <xsl:param name="pRep">\\"</xsl:param>

    <xsl:variable name="onProdList"><xsl:text>onProd.xml</xsl:text></xsl:variable>
    
    <xsl:template match="/">
            <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="dataroot">
        <xsl:apply-templates select="Letter[starts-with(identifier, 'UCCL')]"><xsl:sort select="substring(date, 1, 4)"/></xsl:apply-templates>
    </xsl:template>

    <xsl:template match="Letter">
        <xsl:param name="year" select="substring(date, 1, 4)"/>
        <xsl:param name="month" select="substring(date, 6, 2)"/>
        <xsl:message>LOOKUP FILE IS <xsl:value-of select="$onProdList"/></xsl:message>
        
        <xsl:message select="$year"/><xsl:text>-</xsl:text><xsl:message select="$month"/>
            <xsl:result-document href="../md/{$year}/{$month}/{identifier}.md">
                <xsl:call-template name="yaml-meta"/>
            </xsl:result-document> 
        
        
    </xsl:template>

    <xsl:template name="yaml-meta">
        <xsl:variable name="filename" select="concat(normalize-space(identifier), '.xml')"/>
        <xsl:message>Filename is <xsl:value-of select="$filename"/></xsl:message>
        <xsl:text>---</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>layout: letter</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>identifier: "</xsl:text>
        <xsl:value-of select="normalize-space(identifier)"/>
        <xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>title: "</xsl:text>
        <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(title)))"/>
        <xsl:text>"&#10;</xsl:text>
        <xsl:text>cue: "</xsl:text>
        <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(cue)))"/>
        <xsl:text>"&#10;</xsl:text>
        <xsl:text>place: "</xsl:text>
        <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(place)))"/>
        <xsl:text>"&#10;</xsl:text>
        <xsl:text>writer: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:for-each select="writer">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(.)))"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>addressee: </xsl:text>
        <xsl:text>[</xsl:text>
        <xsl:for-each select="addressee">
            <xsl:text>"</xsl:text>
            <xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(.)))"/>
            <xsl:text>"</xsl:text>
            <xsl:if test="position() != last()">
                <xsl:text>,</xsl:text>
            </xsl:if>
        </xsl:for-each>
        <xsl:text>]</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>rawDate: </xsl:text>
        <xsl:value-of select="replace(replace(replace(normalize-space(date), '0000', '2222'), '00-00', '12-31'),'-00', '-01')"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>catalogue: </xsl:text>
        <xsl:value-of select="normalize-space(substring(identifier, 1, 4))"/>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>source: </xsl:text>
        <xsl:choose>
            <xsl:when test="label  = 'CU-MARK'">"CU-MARK"</xsl:when>
            <xsl:otherwise><xsl:text>"</xsl:text><xsl:value-of select="mtp:trimTrailing(mtp:mardownify(normalize-space(source)))"/><xsl:text>"</xsl:text></xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>onProd: </xsl:text>
	<xsl:choose>
	    <xsl:when test="document($onProdList)//report/incident/description[text() =  $filename]"><xsl:text>true</xsl:text></xsl:when>
         <xsl:otherwise><xsl:text>false</xsl:text></xsl:otherwise>
        </xsl:choose>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>revHist: </xsl:text>
        <xsl:text>"</xsl:text><xsl:value-of select="modified"/><xsl:text>"</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>---</xsl:text>
        <xsl:text>&#10;</xsl:text>
        <xsl:text>## </xsl:text>
        <xsl:value-of select="normalize-space(title)"/>
    </xsl:template>

    <xsl:function name="mtp:mardownify" >
        <xsl:param name="inString"/>
        <xsl:value-of select="replace($inString,$pPat ,$pRep)"/>
    </xsl:function>

    <xsl:function name="mtp:trimTrailing" >
        <xsl:param name="inString"/>
        <xsl:value-of select="replace($inString, '(\.)\.?$' , '')"/>
    </xsl:function>

</xsl:stylesheet>
