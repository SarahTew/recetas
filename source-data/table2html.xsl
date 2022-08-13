<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xs" version="2.0">
    <xsl:output encoding="UTF-8" method="html"/>
    <xsl:template match="/">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- row -->
    <xsl:template match="row">
        <xsl:result-document method="text" encoding="utf-8" href="{id}.html">
        <xsl:apply-templates select="ingredient_list"></xsl:apply-templates>
        <xsl:apply-templates select="directions"></xsl:apply-templates>
        </xsl:result-document>
        <div class="col recipe">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="id"/>
    <xsl:template match="paper"/>
    <xsl:template match="state"/>
    <xsl:template match="course"/>
    <xsl:template match="ingredients"/>
    <xsl:template match="title"/>
    <xsl:template match="url"/>
    <xsl:template match="pdf_file_path"/>
    <xsl:template match="tags"/>
    
    <xsl:template match="ingredient_list">
        <ul class="ingredients">
            <xsl:call-template name="ingredients"/>
            <xsl:apply-templates/>
        </ul>
    </xsl:template>
    
    <xsl:template match="directions">
        <div class="directions">
            <xsl:call-template name="directions"/>
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    
    <!--ingredients_list-->
    <xsl:template name="ingredients">
        <ul id="ingredients">
            <xsl:for-each select="tokenize(.,';')">
                <li>
                    <xsl:value-of select="normalize-space(.)"/>
                </li>
            </xsl:for-each>  
        </ul>
    </xsl:template>

    <xsl:template name="directions">
        <xsl:for-each select="tokenize(.,';')">
            <li>
                <xsl:value-of select="normalize-space(.)"/>
            </li>
        </xsl:for-each>  
    </xsl:template>
    
    <!--default that tells what elements are not defined in this document-->
    <xsl:template match="tei:*">
        <xsl:message>
            <xsl:text>unknown element: </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:message>
    </xsl:template>

</xsl:stylesheet>
