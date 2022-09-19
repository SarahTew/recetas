<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei xs" version="2.0">
    <xsl:output encoding="UTF-8" method="html"/> 
    
    <!-- row -->
    <xsl:template match="row">

            <xsl:apply-templates/>
              
    </xsl:template>
    <xsl:template match="title_en"/>
    <xsl:template match="id"/>
    <xsl:template match="paper"/>
    <xsl:template match="state"/>
    <xsl:template match="course"/>
    <xsl:template match="course_en"/>
    <xsl:template match="ingredients"/>
    <xsl:template match="ingredients_en"/>
    <xsl:template match="ingredient_list"/>
    <xsl:template match="directions"/>
    <xsl:template match="title"/>
    <xsl:template match="tags_en"/>
    <xsl:template match="url"/>
    <xsl:template match="pdf_file_path"/>
    <xsl:template match="tags"/>
    <xsl:template match="ingredient_list_en">
        <div class="ingredients">
            <h4 id="ingredhead">Ingredients</h4>
            <xsl:call-template name="ingredients"/>
        </div>
    </xsl:template>
    <xsl:template match="directions_en">
        <div class="directions">
            <h4 id="dirhead">Directions</h4>
            <xsl:call-template name="directions"/>
        </div>
    </xsl:template>
    <!-- urls -->
    <xsl:template name="make_href">
        <xsl:value-of select="URL"/>
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
        <ol id="directions">
            <xsl:for-each select="tokenize(.,';')">
                <li>
                    <xsl:value-of select="normalize-space(.)"/>
                </li>
            </xsl:for-each>
        </ol>  
    </xsl:template>
    
    <!--default that tells what elements are not defined in this document-->
    <xsl:template match="tei:*">
        <xsl:message>
            <xsl:text>unknown element: </xsl:text>
            <xsl:value-of select="local-name()"/>
        </xsl:message>
    </xsl:template>
    
</xsl:stylesheet>
